# X-apps

Deploys apps for the X team on the SKIP plattform

## Structure

This repo contains a set of predefined directories which Argo CD will look for.
Each of these directories ar placed under `env` in, in a folder corresponding to the cluster environment.
When these are present any subdirectory of these will be picked up by Argo and used to deploy their
contents to a given namespace on kubernetes.

Your team will have a set of defined prefixes which has been set in correspondance with the SKIP team in
[skip-apps/lib/argocd/argocd.libsonnet](https://github.com/kartverket/skip-apps/blob/main/lib/argocd/argocd.libsonnet).
You must prefix all folders under the environment folders with one of these prefixes.

For example, if your team is called `foo` and you wanted the use the `foo` prefix in the cluster `atkv3-dev`,
the below structure would put the contents of `example.yaml` into a namespace called `foo-main` on dev.

```
env/
  atkv3-dev/
    foo-main/
      example.yaml
```

It is common to create namespaces based on branch, allowing for a structure which might look similar to this:

```
env/
  atkv3-dev/
    foo-main/
      example.yaml
    foo-dev/
      example.yaml
    foo-issue-624/
      example.yaml
  atkv3-prod/
    foo-main/
      example.yaml
```

## Reusable templates

Argo supports using [jsonnet](https://jsonnet.org) to build JSON dynamically.

An example of this could be the below file which references a template in a lib
directory that is placed in the root of the repo:

```
local app = import '../../lib/app.libsonnet';

app()

```

## ArgoKit
This template comes with argokit pre-installed, which is the fastest way
to get your apps deployed on SKIP. ArgoKit is a set of reusable jsonnet templates that provide functions for common application needs like configuring secrets, environment, access-policies, as well as external resources.

Check out the getting started guide [here](https://skip.kartverket.no/docs/applikasjon-utrulling/argokit/getting-started)!
```jsonnet
local argokit = import '../../argokit/v2/jsonnet/argokit.libsonnet';
local app = argokit.appAndObjects.application;

app.new(name='foo-backend', image='backend-server', port=8080)
```
The [repo](https://github.com/kartverket/argokit/) is maintained by the SKIP team, and will feature more examples as we see Argo being used!


## Workflows
This template comes with some workflows from the [`github-workflows` repo](https://github.com/kartverket/github-workflows/).
``

### Manifest diff to PR comment
When you create a PR, it will run the `skipctl` [diff](https://skip.kartverket.no/docs/applikasjon-utrulling/skipctl/manifests#diff) command on the manifests in your branch against `origin/main`. The diff will be posted as a comment in the PR. Read more about the workflow [here](https://github.com/kartverket/github-workflows?tab=readme-ov-file#manifest-diff-to-pr-comment).

**Default arguments (change if needed):**
- `path`: env
- `skipctl-version`: latest
- `ref`: origin/main

### Validate manifests
The validate workflow runs the `skipctl` [validate](https://skip.kartverket.no/docs/applikasjon-utrulling/skipctl/manifests#validate) command on the manifests in your branch. This will validate the manifests based on their CRDs. Invalid manifests will cause the workflow to fail. Read more about the workflow [here](https://github.com/kartverket/github-workflows/?tab=readme-ov-file#run-k8s-manifests-validate).

**Default arguments (change if needed)**
- `path`: env
- `skipctl-version`: latest
