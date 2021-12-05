# Create ALB Listner - HTTPS

resource "aws_lb_listener" "bull_https" {   
  load_balancer_arn = aws_lb.bull_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.bull_front_end_tg.arn
  }
}


# Create ALB Listner Backend Rule - HTTPS

resource "aws_lb_listener_rule" "bull_admin_https" {
  listener_arn      = aws_lb_listener.bull_https.arn
  priority          = 100
  action {   
    type             = "forward"
    target_group_arn = aws_lb_target_group.bull_back_end_tg.arn
  }
    condition {
    path_pattern {
      values = ["/admin*"]
    }
  }

}