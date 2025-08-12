import posthog from "posthog-js";

const posthogPublicKey = process.env.NEXT_PUBLIC_POSTHOG_KEY;

if (posthogPublicKey && posthogPublicKey.length > 0) {
  // When built on Vercel, NEXT_PUBLIC_* vars are inlined as literals here.
  posthog.init(posthogPublicKey, {
    api_host: "/relay-giDS",
  });
  console.info("PostHog initialized (key present)");
} else {
  // This will help verify whether the key was inlined at build time.
  console.warn(
    "PostHog not initialized: NEXT_PUBLIC_POSTHOG_KEY is missing or empty",
  );
}
