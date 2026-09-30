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
