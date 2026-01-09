"use client";

import { useRef, useState, useEffect, useCallback } from "react";
import Autoplay from "embla-carousel-autoplay";
import WheelGestures from "embla-carousel-wheel-gestures";
import { Sparkles } from "lucide-react";
import {
  Carousel,
  CarouselContent,
  CarouselItem,
  CarouselNext,
  CarouselPrevious,
  type CarouselApi,
} from "@/components/ui/carousel";
import { Skeleton } from "@/components/ui/skeleton";
import JargonCard from "@/components/jargon/jargon-card";
import { cn } from "@/lib/utils";

export type FeaturedJargonCarouselItem = {
  id: string;
  name: string;
  slug: string;
  updated_at: string;
  translation: string;
  categories: string[];
  comment_count: number;
};

const autoplayPlugin = Autoplay({ delay: 2000, stopOnInteraction: true });
const wheelGesturesPlugin = WheelGestures({ forceWheelAxis: "x" });

export default function FeaturedJargonCarousel({
  featuredJargons,
  className,
}: {
  featuredJargons: FeaturedJargonCarouselItem[];
  className?: string;
}) {
  const [api, setApi] = useState<CarouselApi>();
  const [canScrollPrev, setCanScrollPrev] = useState(false);
  const [canScrollNext, setCanScrollNext] = useState(false);
  const [scrollProgress, setScrollProgress] = useState(0);
  const scrollbarRef = useRef<HTMLDivElement>(null);
  const isDraggingRef = useRef(false);

  const onScroll = useCallback(() => {
    if (!api) return;
    const progress = Math.max(0, Math.min(1, api.scrollProgress()));
    setScrollProgress(progress);
  }, [api]);

  // Calculate scroll position from mouse X and scroll to that slide
  const scrollToPosition = useCallback(
    (clientX: number) => {
      if (!api || !scrollbarRef.current) return;
      const rect = scrollbarRef.current.getBoundingClientRect();
      const percentage = Math.max(
        0,
        Math.min(1, (clientX - rect.left) / rect.width),
      );
      const scrollSnapList = api.scrollSnapList();
      const targetIndex = Math.round(percentage * (scrollSnapList.length - 1));
      api.scrollTo(targetIndex);
    },
    [api],
  );

  // Handle mouse down on scrollbar (start drag)
  const handleScrollbarMouseDown = useCallback(
    (e: React.MouseEvent<HTMLDivElement>) => {
      e.preventDefault();
      isDraggingRef.current = true;
      scrollToPosition(e.clientX);
    },
    [scrollToPosition],
  );

  // Handle mouse move (drag) and mouse up (end drag)
  useEffect(() => {
    const handleMouseMove = (e: MouseEvent) => {
      if (!isDraggingRef.current) return;
      scrollToPosition(e.clientX);
    };

    const handleMouseUp = () => {
      isDraggingRef.current = false;
    };

    document.addEventListener("mousemove", handleMouseMove);
    document.addEventListener("mouseup", handleMouseUp);
    return () => {
      document.removeEventListener("mousemove", handleMouseMove);
      document.removeEventListener("mouseup", handleMouseUp);
    };
  }, [scrollToPosition]);

  useEffect(() => {
    if (!api) {
      return;
    }

    setCanScrollPrev(api.canScrollPrev());
    setCanScrollNext(api.canScrollNext());
    onScroll();

    const onSelect = () => {
      setCanScrollPrev(api.canScrollPrev());
      setCanScrollNext(api.canScrollNext());
    };
    api.on("select", onSelect);
    api.on("scroll", onScroll);
    api.on("reInit", onScroll);
    return () => {
      api.off("select", onSelect);
      api.off("scroll", onScroll);
      api.off("reInit", onScroll);
    };
  }, [api, onScroll]);

  return (
    <div
      className={cn(
        "relative overflow-hidden rounded-xl bg-[#fab1a0] p-4 shadow-sm dark:bg-[#3e2620]",
        className,
      )}
    >
      <div className="flex flex-col gap-3">
        <h2 className="flex items-center gap-2 text-lg font-bold">
          <span className="text-amber-900 dark:text-amber-100">
            <Sparkles className="h-4 w-4" />
          </span>
          <span className="text-amber-900 dark:text-amber-100">하이라이트</span>
        </h2>
        <Carousel
          setApi={setApi}
          plugins={[autoplayPlugin, wheelGesturesPlugin]}
          className="relative w-full"
          onMouseEnter={autoplayPlugin.stop}
          onMouseLeave={autoplayPlugin.reset}
        >
          {/* Left fade overlay */}
          {canScrollPrev && (
            <div className="pointer-events-none absolute top-0 left-0 z-10 h-full w-16 bg-gradient-to-r from-[#fab1a0] to-transparent dark:from-[#3e2620]" />
          )}
          {/* Right fade overlay */}
          {canScrollNext && (
            <div className="pointer-events-none absolute top-0 right-0 z-10 h-full w-16 bg-gradient-to-l from-[#fab1a0] to-transparent dark:from-[#3e2620]" />
          )}
          <CarouselContent className="-ml-3">
            {featuredJargons.length > 0
              ? featuredJargons.map((jargon) => (
                  <CarouselItem
                    key={jargon.id + "-" + jargon.translation}
                    className="basis-1/2 pl-3 md:basis-1/3 lg:basis-1/4 xl:basis-1/5"
                  >
                    <JargonCard
                      jargon={{
                        id: jargon.id,
                        name: jargon.name,
                        slug: jargon.slug,
                        translations: jargon.translation
                          ? [jargon.translation]
                          : [],
                        categories: jargon.categories,
                        commentCount: jargon.comment_count,
                        updatedAt: jargon.updated_at,
                      }}
                      compact
                    />
                  </CarouselItem>
                ))
              : Array.from({ length: 8 }).map((_, index) => (
                  <CarouselItem
                    key={index}
                    className="basis-1/2 pl-3 md:basis-1/3 lg:basis-1/4 xl:basis-1/5"
                  >
                    <div className="bg-card text-card-foreground flex h-full flex-col gap-1 rounded-md p-3">
                      {/* Name skeleton */}
                      <Skeleton className="h-5 w-3/4" />

                      {/* Translation skeleton */}
                      <Skeleton className="h-4 w-full" />

                      {/* Footer skeleton (comment count + timestamp) */}
                      <div className="mt-auto flex gap-1 self-end">
                        <Skeleton className="h-4 w-12" />
                        <Skeleton className="h-4 w-16" />
                      </div>
                    </div>
                  </CarouselItem>
                ))}
          </CarouselContent>
          {canScrollPrev && (
            <CarouselPrevious className="left-2 z-20 border-stone-200 bg-white hover:bg-stone-50 dark:border-stone-700 dark:bg-stone-900 dark:hover:bg-stone-800" />
          )}
          {canScrollNext && (
            <CarouselNext className="right-2 z-20 border-stone-200 bg-white hover:bg-stone-50 dark:border-stone-700 dark:bg-stone-900 dark:hover:bg-stone-800" />
          )}
        </Carousel>
        {/* Horizontal scroll progress bar - visible on desktop only */}
        <div
          ref={scrollbarRef}
          onMouseDown={handleScrollbarMouseDown}
          className="mt-3 hidden h-2 w-full cursor-pointer rounded-full bg-amber-200/50 md:block dark:bg-amber-900/30"
        >
          <div
            className="pointer-events-none h-full rounded-full bg-amber-900 transition-transform duration-75 ease-out dark:bg-amber-50"
            style={{
              width: "20%",
              transform: `translateX(${scrollProgress * 400}%)`,
            }}
          />
        </div>
      </div>
    </div>
  );
}
