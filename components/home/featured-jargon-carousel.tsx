"use client";

import { useRef, useState, useEffect } from "react";
import Autoplay from "embla-carousel-autoplay";
import { Award } from "lucide-react";
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
}: {
  featuredJargons: FeaturedJargonCarouselItem[];
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
    <div className="flex flex-col gap-3">
      <h2 className="flex items-center gap-2 text-lg font-bold">
        <Award className="h-5 w-5" />
        하이라이트
      </h2>
      <Carousel
        setApi={setApi}
        plugins={[plugin.current]}
        className="w-full"
        onMouseEnter={plugin.current.stop}
        onMouseLeave={plugin.current.reset}
      >
        <CarouselContent className="-ml-4">
          {featuredJargons.length > 0
            ? featuredJargons.map((jargon) => (
                <CarouselItem
                  key={jargon.id}
                  className="basis-full md:basis-1/2 lg:basis-1/3 xl:basis-1/4"
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
                  />
                </CarouselItem>
              ))
            : Array.from({ length: 8 }).map((_, index) => (
                <CarouselItem
                  key={index}
                  className="basis-full md:basis-1/2 lg:basis-1/3 xl:basis-1/4"
                >
                  <div className="bg-card text-card-foreground flex h-full flex-col gap-1 rounded-md p-3">
                    {/* Category chips skeleton */}
                    <div className="flex flex-wrap gap-2">
                      <Skeleton className="h-5 w-12 rounded-full" />
                      <Skeleton className="h-5 w-10 rounded-full" />
                    </div>

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
        {canScrollPrev && <CarouselPrevious className="left-1" />}
        {canScrollNext && <CarouselNext className="right-1" />}
      </Carousel>
    </div>
  );
}
