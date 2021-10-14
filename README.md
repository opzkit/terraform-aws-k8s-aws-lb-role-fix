# terraform-aws-k8s-aws-lb-role-fix

Temporary module for adding ACM privileges to the IRSA-role created by [kOps](https://kops.sigs.k8s.io) for
the [AWS LoadBalancer Controller](https://kubernetes-sigs.github.io/aws-load-balancer-controller).

Not to be used after PR [#12309](https://github.com/kubernetes/kops/pull/12309) is merged and released.
