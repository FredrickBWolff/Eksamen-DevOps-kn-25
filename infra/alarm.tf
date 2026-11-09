resource "aws_cloudwatch_metric_alarm" "suggestions_per_image" {
  alarm_name          = "wishifai-kn-${var.kandidatnummer}-suggestions-per-image"
  alarm_description   = "Alarm when the number of generated gift suggestions per image is less than 3."
  comparison_operator = "LessThanThreshold"
  threshold           = 3
  evaluation_periods  = 3
  treat_missing_data  = "notBreaching"


  metric_query {
    id          = "e1"
    expression  = "m1 / (FILL(m2, 0) + FILL(m3, 0) + FILL(m4, 0) + FILL(m5, 0))"
    label       = "Gjennomsnittlig antall genererte gaveforslag per bilde"
    return_data = true
  }

  metric_query {
    id = "m1"
    metric {
      namespace   = var.metric_namespace
      metric_name = "gift.suggestions.generated.count"
      period      = 300
      stat        = "Sum"
    }
  }

  metric_query {
    id = "m2"
    metric {
      namespace   = var.metric_namespace
      metric_name = "images.analyzed.count"
      dimensions = {
        roomType = "stue"
      }
      period = 300
      stat   = "Sum"
    }
  }

  metric_query {
    id = "m3"
    metric {
      namespace   = var.metric_namespace
      metric_name = "images.analyzed.count"
      dimensions = {
        roomType = "barnerom"
      }
      period = 300
      stat   = "Sum"
    }
  }

  metric_query {
    id = "m4"
    metric {
      namespace   = var.metric_namespace
      metric_name = "images.analyzed.count"
      dimensions = {
        roomType = "garasje"
      }
      period = 300
      stat   = "Sum"
    }
  }

  metric_query {
    id = "m5"
    metric {
      namespace   = var.metric_namespace
      metric_name = "images.analyzed.count"
      dimensions = {
        roomType = "En ukjent rom type"
      }
      period = 300
      stat   = "Sum"
    }
  }
}