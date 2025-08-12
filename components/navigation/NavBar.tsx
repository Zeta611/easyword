import NavBarAvatar from "@/components/navigation/NavBarAvatar";
import NavBarSearchDialog from "@/components/navigation/NavBarSearchDialog";
import NavBarTitle from "@/components/navigation/NavBarTitle";
import SuggestJargonDialog from "@/components/dialogs/SuggestJargonDialog";

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
