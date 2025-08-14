import NavBarAvatar from "@/components/navigation/nav-bar-avatar";
import NavBarSearchDialog from "@/components/navigation/nav-bar-search-dialog";
import NavBarTitle from "@/components/navigation/nav-bar-title";
import SuggestJargonDialog from "@/components/dialogs/suggest-jargon-dialog";
import { Separator } from "@/components/ui/separator";
import { SidebarTrigger } from "@/components/ui/sidebar";

export default function NavBar() {
  return (
    <nav className="sticky top-0 z-50">
      <div className="bg-accent-f mb-4 flex items-start justify-between pt-4">
        <div className="flex items-start gap-4">
          <SidebarTrigger className="text-muted-foreground mt-2.5 backdrop-blur-xs" />
          <NavBarTitle />
        </div>
        <div className="bg-background/10 flex items-center gap-2.5 rounded-xl p-1 backdrop-blur-xs">
          <NavBarSearchDialog />
          <SuggestJargonDialog />
          <Separator
            orientation="vertical"
            className="data-[orientation=vertical]:!h-5.5"
          />
          <NavBarAvatar />
        </div>
      </div>
    </nav>
  );
}
