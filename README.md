# GitHub Pages Knowledge Base — Starter

This repo is a minimal starter for a public knowledge base on **GitHub Pages** using the **just-the-docs** theme.

## How to use
1. Create a new repo on GitHub (public is fine).
2. Download this ZIP, unzip, and commit all files to your repo.
3. In **Settings → Pages**:
   - Source: **Deploy from a branch**
   - Branch: **main** and folder **/docs**
   - Save.
4. Wait for the first build to finish. You'll get a Pages URL.
5. Edit the content in `docs/` and push changes.

## Optional
- Connect your custom subdomain (e.g., `kb.example.com`) by adding a **CNAME** record to your Pages hostname. Then set the same name in **Settings → Pages → Custom domain**.
- Toggle **Enforce HTTPS** in Pages settings.
- Tweak navigation by editing front matter (`nav_order`, `has_children`, `parent`) in pages.
