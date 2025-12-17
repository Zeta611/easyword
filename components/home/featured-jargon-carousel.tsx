"use client";

import { useRef, useState, useEffect } from "react";
import Autoplay from "embla-carousel-autoplay";
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

export default function FeaturedJargonCarousel({
  featuredJargons,
  className,
}: {
  featuredJargons: FeaturedJargonCarouselItem[];
  className?: string;
}) {
  const plugin = useRef(Autoplay({ delay: 2000, stopOnInteraction: true }));
  const [api, setApi] = useState<CarouselApi>();
  const [canScrollPrev, setCanScrollPrev] = useState(false);
  const [canScrollNext, setCanScrollNext] = useState(false);

  useEffect(() => {
    if (!api) {
      return;
    }

    setCanScrollPrev(api.canScrollPrev());
    setCanScrollNext(api.canScrollNext());

    const onSelect = () => {
      setCanScrollPrev(api.canScrollPrev());
      setCanScrollNext(api.canScrollNext());
    };
    api.on("select", onSelect);
    return () => {
      api.off("select", onSelect);
    };
  }, [api]);

  return (
    <div
      className={cn(
        "animate-gradient-flow relative overflow-hidden rounded-xl p-4 shadow-sm",
        className,
      )}
    >
      <div className="flex flex-col gap-3">
        <h2 className="flex items-center gap-2 text-lg font-bold">
          <span className="text-amber-500 dark:text-amber-400">
            <Sparkles className="h-4 w-4" />
          </span>
          <span className="text-amber-800 dark:text-amber-100">하이라이트</span>
        </h2>
        <Carousel
          setApi={setApi}
          plugins={[plugin.current]}
          className="relative w-full"
          onMouseEnter={plugin.current.stop}
          onMouseLeave={plugin.current.reset}
        >
          {/* Left fade overlay */}
          {canScrollPrev && (
            <div className="pointer-events-none absolute top-0 left-0 z-10 h-full w-16 bg-gradient-to-r from-amber-50/90 to-transparent dark:from-amber-950/60" />
          )}
          {/* Right fade overlay */}
          {canScrollNext && (
            <div className="pointer-events-none absolute top-0 right-0 z-10 h-full w-16 bg-gradient-to-l from-yellow-50/90 to-transparent dark:from-stone-900/60" />
          )}
          <CarouselContent className="-ml-3">
            {featuredJargons.length > 0
              ? featuredJargons.map((jargon) => (
                  <CarouselItem
                    key={jargon.id}
                    className="basis-full pl-3 md:basis-1/2 lg:basis-1/3 xl:basis-1/4"
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
                    className="basis-full pl-3 md:basis-1/2 lg:basis-1/3 xl:basis-1/4"
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
      </div>
    </div>
  );
}
