export default function About() {
  return (
    <div className="mx-auto max-w-3xl px-4 mt-10">
      <div className="panel rounded-2xl p-6">
        <h2 className="text-white text-xl font-semibold mb-2">User Profile</h2>
        <p className="text-sm text-gray-300 leading-7">
          Iâ€™m Cesar Francis, a first-year CS student at the Lebanese University. I like building
          things that feel fast, minimal, and a bit nerdy â€” with small details that make engineers
          nod and recruiters smile. My favorite toys: React, TypeScript, Tailwind, and physics-inspired
          visualizations.
        </p>
        <ul className="text-sm text-gray-300 mt-4 list-disc pl-5 space-y-1">
          <li>Focus areas: front-end engineering, UI motion, algorithms.</li>
          <li>Values: clarity, performance, and accessible design.</li>
          <li>Fun: I turn course topics into interactive demos.</li>
        </ul>
      </div>
    </div>
  )
}

