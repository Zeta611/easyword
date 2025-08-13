"use client";

import { useState } from "react";
import { Share, ClipboardCheck } from "lucide-react";
import { Button } from "@/components/ui/button";

export default function ShareButton({ label = "공유" }: { label?: string }) {
  const [copied, setCopied] = useState(false);

  async function onCopy() {
    try {
      await navigator.clipboard.writeText(window.location.href);
      setCopied(true);
      setTimeout(() => setCopied(false), 1200);
    } catch (error) {
      console.error(error);
    }
  }

  return (
    <Button variant="outline" size="sm" onClick={onCopy} className="gap-1">
      {copied ? (
        <ClipboardCheck className="size-3.5" />
      ) : (
        <Share className="size-3.5" />
      )}
      <span className="text-xs">{copied ? "복사됨" : label}</span>
    </Button>
  );
}
