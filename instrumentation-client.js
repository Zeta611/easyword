import posthog from "posthog-js";

posthog.init(process.env.NEXT_PUBLIC_POSTHOG_KEY, {
  api_host: "/relay-giDS",
  defaults: "2025-05-24",
});
