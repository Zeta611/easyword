import NavBarAvatar from "@/components/NavBarAvatar";
import NavBarSearchButton from "@/components/NavBarSearchButton";
import NavBarTitle from "@/components/NavBarTitle";

export default function NavBar() {
  return (
    <nav className="sticky top-0 z-50">
      <div className="mb-4 flex items-start justify-between pt-4">
        <NavBarTitle />
        <div className="flex items-center gap-4.5">
          <NavBarSearchButton />
          <NavBarAvatar />
        </div>
      </div>
    </nav>
  );
}
