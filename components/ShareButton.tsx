"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Share2, Check } from "lucide-react";

export default function ShareButton({ label = "공유" }: { label?: string }) {
  const [copied, setCopied] = useState(false);

  async function onCopy() {
    try {
      await navigator.clipboard.writeText(window.location.href);
      setCopied(true);
      setTimeout(() => setCopied(false), 1200);
    } catch (e) {
      // no-op
    }
  }

  return (
    <Button variant="outline" size="sm" onClick={onCopy} className="gap-1">
      {copied ? <Check className="h-3.5 w-3.5" /> : <Share2 className="h-3.5 w-3.5" />}
      <span className="text-xs">{copied ? "복사됨" : label}</span>
    </Button>
  );
}