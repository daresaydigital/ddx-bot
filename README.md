# DDX Bot — digital starter kit

`index.html` is **Plain Bot**: a full-screen ASCII robot face for a phone. It blinks,
glances around, types (and on tap, says aloud) lines like *"I need an identity."*
It's the "before" picture. Each team's job is to give it a personality.

- One self-contained file, no build step, no dependencies. Paste it into any AI tool and it still works.
- Everything worth changing sits in the `BOT` config at the top of the script: lines, voice, ASCII eyes and mouth, timing.
- Text scales to fill the screen in portrait or landscape.
- The first tap starts the voice, keeps the screen awake (Wake Lock) and goes full screen where the browser allows it.

## Getting it onto the phone

The quickest way for teams is to **paste into Claude (claude.ai) and ask for an artifact**. Then open the
link on the phone. Other tools work too (Lovable, v0, Bolt, ChatGPT canvas…) as long as they give you a URL the phone can open.

For your own demo phone, host the file once, somewhere simple:
- **Netlify Drop** (app.netlify.com/drop): drag the folder in and you get a URL.
- **GitHub Pages**: push the file and turn on Pages.
- Same Wi-Fi: `python3 -m http.server 8000` and open `http://<laptop-ip>:8000` on the phone.

iPhone: *Share → Add to Home Screen* opens it with no Safari UI, which is the cleanest face.
Also turn off auto-lock, or rely on the page's Wake Lock.

## Team slots and the deploy desk

There are 12 team URLs, `daresaydigital.github.io/ddx-bot/team-1/` … `team-12/`.
Each one shows Plain Bot (labelled with the team number) until a team's own face is published there.
The overview page with a QR code per team (it prints 3×4 on A4) is at
**daresaydigital.github.io/ddx-bot/teams/**.

At the start, every team scans its QR code on the robot's phone and adds it to the home screen.
Later, they only need to reload.

Teams never touch GitHub. To get a team's face live:

1. The team shares its Claude artifact with Robert **with edit access** and sends the link.
   (Fallback: they download or copy the code and send the file.)
2. Robert gives the link to Claude Code ("publish to team 3"), or saves the file and runs:

   ```bash
   ./deploy.sh 3 ~/Downloads/robot.html
   ```

3. It's live in about a minute. The team reloads the phone.

If the team's prototype is already hosted (Lovable, Figma Make, a Figma prototype link…), skip the file
and redirect the team URL to it:

```bash
./deploy.sh 3 https://something.lovable.app
```

**Several surfaces per robot:** the team URL is surface 1. Extra phones use `team-3/2/`, `team-3/3/` (up to 9).
Surfaces 2 and 3 already show Plain Bot for every team; the overview page shows their QR codes under "+ more surfaces".

```bash
./deploy.sh 3/2 ~/Downloads/chest.html
```

`./deploy.sh 3 --reset` puts Plain Bot back for one team, `./deploy.sh all --reset` for all teams (and removes surfaces 4–9).
The script adds the phone viewport tag when artifact code lacks one, so the face doesn't render tiny.

Figma teams skip the desk and play their prototype full screen in the Figma app.

## Prompt card for teams

> Here is a starter HTML file for a robot face that runs full screen on a phone
> (pasted below). It's deliberately boring. Our robot represents **[who we are as
> DDX / our team's take]**. Its personality is **[3 adjectives]**, and it
> reacts to **[tap / shake / time of day / sound…]**. Rework the face, the
> colours, the motion and what it says to express that. Keep it a single HTML
> file that fills a phone screen, portrait orientation.
>
> [paste index.html]

Prompts you can add when a team gets stuck:
- "Make it react when I shake the phone" (DeviceMotion; iOS asks for permission on tap)
- "Swap the ASCII for an SVG / emoji / pixel-art face"
- "Let it listen: react to loud sounds from the microphone"
- "Give it moods that change over time"
- "Use the camera and make the eyes follow a face" (ambitious for 75 min)

## Suggested 75-minute flow

| Time | What |
|---|---|
| 0–10 | Plain Bot demo ("what not to do") and the brief |
| 10–20 | Team decides on its identity: 3 adjectives, what it says, how it behaves |
| 20–60 | Split the work: builders on the physical body, 1–2 vibe-coding the face |
| 60–75 | Mount the phones, then each robot introduces itself |

Tip: tell teams to get the phone showing *their URL* by minute ~45 so the last 15 minutes go to polish rather than debugging.
