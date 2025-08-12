import posthog from "posthog-js";

posthog.init(process.env.NEXT_PUBLIC_POSTHOG_KEY, {
  api_host: "/relay-giDS/",
  ui_host: "https://us.posthog.com",
  defaults: "2025-05-24",
});
