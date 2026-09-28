# Repository Guidelines

## Project Structure & Module Organization

This repository stores deployment configuration rather than application source code. Shared Nginx snippets live in `includes/` (`gzip.conf`, `security.conf`, and static/CORS rules). Remaining service-specific files are grouped under `config/`: `nginxair/` contains virtual hosts, `supervisorgee/` contains process definitions, and `dockermazey/` and `dockernode/` retain older image definitions. Webgee and Webmazey virtual hosts and Docker inputs are owned by the sibling `server/scripts/webdocker/config/` directory. Host-file examples are in `config/hosthome/`, while retired configuration is retained in `archives/`. Root-level assets such as `favicon.ico` and `robots.txt` are served directly.

## Build, Test, and Development Commands

The former `config/nginxgee/` and `config/nginxmazey/` virtual hosts have moved to
`../server/scripts/webdocker/config/webgee/conf.d/` and
`../server/scripts/webdocker/config/webmazey/conf.d/`. Edit and validate them there.
Shared snippets remain in `includes/` and are still loaded through `/web/conf/includes/`.

There is no application build or automated test suite in this repository; `npm test` is a placeholder that intentionally fails. Validate the files affected by a change:

```bash
nginx -t                         # validate the installed Nginx configuration
bash -n ../server/scripts/webdocker/config/webmazey/docker-entrypoint.sh
npx markdownlint-cli2 "**/*.md" # check Markdown against .markdownlint.json
docker build -f ../server/scripts/webdocker/config/webgee/Dockerfile ..
```

The Docker command uses the parent directory as its build context because the image copies both `./conf` and sibling projects such as `./x`. Webgee's Dockerfile and build-context ignore source now live in `../server/scripts/webdocker/config/webgee/`; use that project's `webgee-build.sh` to stage both inputs for a release. Webmazey's main Nginx and Supervisor files now live in `../server/scripts/webdocker/config/webmazey/`. A standalone checkout may not provide the complete context. Test Nginx changes in a container or host layout that satisfies absolute paths such as `/web/conf`.

## Coding Style & Naming Conventions

Webmazey's authoritative entrypoint is `../server/scripts/webdocker/config/webmazey/docker-entrypoint.sh`.
The retained `config/dockermazey/Dockerfile` copies it from that location; no local duplicate remains.

Follow `.editorconfig`: UTF-8, LF endings, a final newline, trimmed trailing whitespace, and two-space indentation. Keep shell scripts compatible with Bash and begin defensive entrypoints with `set -e`. Use lowercase, descriptive configuration names; virtual hosts follow `<domain>.conf`, while grouped Docker and Supervisor directories use their target service name. Preserve the established ordering of Nginx directives: paths and indexes, lookup/error behavior, caching/security, access control, then logging.

## Testing Guidelines

For every changed `.conf`, run `nginx -t` against the assembled deployment configuration. Exercise redirects, proxy routes, static aliases, and custom error pages with `curl` where relevant. For Docker changes, build the affected image and confirm its entrypoint reaches a successful Nginx validation. Never commit real secrets, certificates, or production-only credentials; secret patterns are ignored by Git.

## Commit & Pull Request Guidelines

Recent history follows Conventional Commits, commonly `feat(scope): summary`, `fix: summary`, `docs(scope): summary`, or `chore(scope): summary`. Keep the subject imperative and name the affected service or domain as the scope. Pull requests should describe the routing or deployment impact, list validation commands, link related issues, and include representative `curl` output for behavior changes. Call out required DNS, filesystem, port, or sibling-service dependencies.
