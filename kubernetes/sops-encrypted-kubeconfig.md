#

```sh
# decrypt age key
export SOPS_AGE_KEY=$(age -d ~/.age/key.txt_encrypted)

# use encrypted kubeconfig
sops exec-file --no-fifo ~/path/to/encrypted/kubeconfig.yaml "KUBECONFIG={} kubectl get pods"

# or spawn a shell with KUBECONFIG
sops exec-file --no-fifo ~/path/to/encrypted/kubeconfig.yaml "KUBECONFIG={} zsh"

# optional: update prompt
PS1="(sops) $PS1"
```
