import { cn } from "@/lib/utils";

export default function Kbd({
  className,
  ...props
}: React.ComponentProps<"kbd">) {
  return (
    <kbd
      className={cn(
        "bg-muted pointer-events-none hidden h-5.5 items-center gap-1 rounded border px-1.5 font-mono text-xs sm:flex",
        className,
      )}
      {...props}
    />
  );
}
