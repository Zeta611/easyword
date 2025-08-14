import { Home, Lightbulb, RadioTower, Rocket, Swords } from "lucide-react";
import Link from "next/link";
import GitHub from "@/components/icons/git-hub";
import {
  Sidebar,
  SidebarContent,
  SidebarFooter,
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
} from "@/components/ui/sidebar";
import { ModeToggle } from "@/components/theme/mode-toggle";

const features = [
  {
    title: "홈",
    url: "/",
    icon: Home,
  },
  {
    title: "용어 vs 용어",
    url: "/arena",
    icon: Swords,
  },
];

const docs = [
  {
    title: "배경 / 원칙",
    url: "/background",
    icon: RadioTower,
  },
  {
    title: "쉬운 번역팁",
    url: "/tips",
    icon: Lightbulb,
  },
  {
    title: "제작기",
    url: "/colophon",
    icon: Rocket,
  },
];

export function SideBar() {
  return (
    <Sidebar collapsible="icon">
      <SidebarContent className="bg-background">
        <SidebarGroup>
          <SidebarGroupLabel>바로가기</SidebarGroupLabel>
          <SidebarGroupContent>
            <SidebarMenu>
              {features.map((item) => (
                <SidebarMenuItem key={item.title}>
                  <SidebarMenuButton asChild>
                    <Link href={item.url}>
                      <item.icon />
                      <span>{item.title}</span>
                    </Link>
                  </SidebarMenuButton>
                </SidebarMenuItem>
              ))}
            </SidebarMenu>
          </SidebarGroupContent>
        </SidebarGroup>
        <SidebarGroup>
          <SidebarGroupLabel>알아보기</SidebarGroupLabel>
          <SidebarGroupContent>
            <SidebarMenu>
              {docs.map((item) => (
                <SidebarMenuItem key={item.title}>
                  <SidebarMenuButton asChild>
                    <Link href={item.url}>
                      <item.icon />
                      <span>{item.title}</span>
                    </Link>
                  </SidebarMenuButton>
                </SidebarMenuItem>
              ))}
            </SidebarMenu>
          </SidebarGroupContent>
        </SidebarGroup>
      </SidebarContent>
      <SidebarFooter>
        <SidebarMenu>
          <SidebarMenuItem>
            <SidebarMenuButton asChild>
              <Link
                href="https://github.com/Zeta611/easyword"
                target="_blank"
                rel="noopener noreferrer"
                aria-label="GitHub Repository"
              >
                <GitHub className="size-4" />
                <span>깃헙 저장소</span>
              </Link>
            </SidebarMenuButton>
          </SidebarMenuItem>
          <SidebarMenuItem>
            <ModeToggle />
          </SidebarMenuItem>
        </SidebarMenu>
      </SidebarFooter>
    </Sidebar>
  );
}
