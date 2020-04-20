.PHONY: install-argocd get-argocd-password proxy-argocd-ui check-argocd-ready

get-argocd-password:
	kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2

check-argocd-ready:
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s

proxy-argocd-ui:
	kubectl port-forward svc/argocd-server -n argocd 8080:80

install-argocd:
	kubectl apply -k argocd-bootstrap/
