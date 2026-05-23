# Helm Charts

```bash
echo >> lab/renovatebotwrapper/values.yaml
.github/helm-dep.sh
```

## gateway-api-crd

via https://github.com/traefik/traefik-helm-chart?tab=readme-ov-file#upgrading

```bash
SOURCE=https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.5.1/standard-install.yaml
VERSION=gateway-api-crd-$(echo ${SOURCE##*download/} | tr / -)
rm -fr gateway-api-crd/templates
mkdir -p gateway-api-crd/templates
curl -o gateway-api-crd/templates/${VERSION} -L $SOURCE
git add gateway-api-crd
git commit -m "track $VERSION"
```


## knative

via https://knative.dev/docs/install/operator/knative-with-operators/

```bash
SOURCE=https://github.com/knative/operator/releases/download/knative-v1.19.5/operator.yaml
VERSION=$(echo ${SOURCE##*download/} | tr / -)
rm -fr knative/templates
mkdir -p knative/templates
curl -o knative/templates/${VERSION} -L $SOURCE
git add knative
git commit -m "track $VERSION"
```
