resource "aws_lb" "master" {
    count                               = var.create_lb ? 1 : 0 
    name                                = format("${var.name}-${var.load_balancer_type}-lb")
    internal                            = var.internal
    load_balancer_type                  = var.load_balancer_type
    subnets                             = var.internal ? var.private_subnet_ids : var.public_subnet_ids
    enable_deletion_protection          = var.enable_deletion_protection
    enable_cross_zone_load_balancing    = var.enable_cross_zone_load_balancing
    enable_http2                        = var.enable_http2
    idle_timeout                        = var.idle_timeout
    ip_address_type                     = var.ip_address_type
    depends_on                          = [var.lb_depends_on]
    tags = merge(
        {
            "Name" = format("${var.name}-${var.load_balancer_type}")
        },
        var.tags,
        var.lb_tags
    )
}

resource "aws_lb_listener" "frontend_http_tcp" {
  count             = var.create_lb ? length(var.http_tcp_listeners) : 0
  load_balancer_arn = aws_lb.master[0].arn
  port              = var.http_tcp_listeners[count.index]["port"]
  protocol          = var.http_tcp_listeners[count.index]["protocol"]
  depends_on        = [aws_lb_target_group.master]
  default_action {
    target_group_arn = aws_lb_target_group.master[lookup(var.http_tcp_listeners[count.index], "target_group_index", count.index)].id
    type             = "forward"
  }
}

/* resource "aws_lb_listener" "frontend_https" {
  count = var.create_lb ? length(var.https_listeners) : 0
  load_balancer_arn = aws_lb.master[0].arn
  port            = var.https_listeners[count.index]["port"]
  protocol        = lookup(var.https_listeners[count.index], "protocol", "HTTPS")
  certificate_arn = var.https_listeners[count.index]["certificate_arn"]
  ssl_policy      = lookup(var.https_listeners[count.index], "ssl_policy", var.listener_ssl_policy_default)
  default_action {
    target_group_arn = aws_lb_target_group.master[lookup(var.https_listeners[count.index], "target_group_index", count.index)].id
    type             = "forward"
  }
}

resource "aws_lb_listener_certificate" "https_listener" {
  count = var.create_lb ? length(var.extra_ssl_certs) : 0

  listener_arn    = aws_lb_listener.frontend_https[var.extra_ssl_certs[count.index]["https_listener_index"]].arn
  certificate_arn = var.extra_ssl_certs[count.index]["certificate_arn"]
} */


