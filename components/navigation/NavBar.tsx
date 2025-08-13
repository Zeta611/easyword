import Link from "next/link";
import NavBarAvatar from "@/components/navigation/NavBarAvatar";
import NavBarSearchDialog from "@/components/navigation/NavBarSearchDialog";
import NavBarTitle from "@/components/navigation/NavBarTitle";
import SuggestJargonDialog from "@/components/dialogs/SuggestJargonDialog";
import GitHub from "@/components/icons/GitHub";
import { Separator } from "@/components/ui/separator";

export default function NavBar() {
  return (
    <nav className="sticky top-0 z-50">
      <div className="bg-accent-f mb-4 flex items-start justify-between pt-4">
        <NavBarTitle />
        <div className="bg-background/10 flex items-center gap-2.5 rounded-xl p-1 backdrop-blur-xs">
          <NavBarSearchDialog />
          <SuggestJargonDialog />
          <Separator
            orientation="vertical"
            className="data-[orientation=vertical]:!h-5.5"
          />
          <Link
            href="https://github.com/Zeta611/easyword"
            target="_blank"
            rel="noopener noreferrer"
            aria-label="GitHub Repository"
          >
            <GitHub className="text-foreground/70 size-5" />
          </Link>
          <NavBarAvatar />
        </div>
      </div>
    </nav>
  );
}
