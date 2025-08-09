import NavBarAvatar from "@/components/NavBarAvatar";
import NavBarSearchDialog from "@/components/NavBarSearchDialog";
import NavBarTitle from "@/components/NavBarTitle";
import SuggestJargonDialog from "@/components/SuggestJargonDialog";

export default function NavBar() {
  return (
    <nav className="sticky top-0 z-50">
      <div className="mb-4 flex items-start justify-between pt-4">
        <NavBarTitle />
        <div className="flex items-center gap-4.5">
          <NavBarSearchDialog />
          <SuggestJargonDialog />
          <NavBarAvatar />
        </div>
      </div>
    </nav>
  );
}
