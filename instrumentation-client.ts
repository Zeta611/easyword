import posthog from "posthog-js";

const posthogPublicKey = process.env.NEXT_PUBLIC_POSTHOG_KEY;

if (posthogPublicKey) {
  posthog.init(posthogPublicKey, {
    api_host: "/relay-giDS",
  });
  console.info("PostHog initialized");
} else {
  console.warn(
    "PostHog not initialized: NEXT_PUBLIC_POSTHOG_KEY is missing or empty",
  );
}
