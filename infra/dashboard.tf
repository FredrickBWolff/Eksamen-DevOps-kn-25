resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "wishifai-kn-${var.kandidatnummer}"
  dashboard_body = <<DASHBOARD
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
          "metrics": [
              ["${var.metric_namespace}", "images.analyzed.count", "roomType", "stue"],
              ["${var.metric_namespace}", "images.analyzed.count", "roomType", "barnerom"],
              ["${var.metric_namespace}", "images.analyzed.count", "roomType", "garasje"],
              ["${var.metric_namespace}", "images.analyzed.count", "roomType", "En ukjent rom type"]
          ],
          "period": 300,
          "stat": "Sum",
          "region": "${var.region}",
          "title": "Antall analyserte bilder per romtype"
      }
    },
    {
        "type": "metric",
        "x": 12,
        "y": 0,
        "width": 12,
        "height": 6,
        "properties": {
            "metrics": [
                [{"expression": "m1 / (FILL(m2, 0) + FILL(m3, 0) + FILL(m4, 0) + FILL(m5, 0))", "label": "Gjennomsnittlig antall genererte gaveforslag per bilde", "id": "e1" }],
                ["${var.metric_namespace}", "gift.suggestions.generated.count", { "id": "m1", "visible": false } ],
                ["${var.metric_namespace}", "images.analyzed.count", "roomType", "stue", { "id": "m2", "visible": false } ],
                ["${var.metric_namespace}", "images.analyzed.count", "roomType", "barnerom", { "id": "m3", "visible": false } ],
                ["${var.metric_namespace}", "images.analyzed.count", "roomType", "garasje", { "id": "m4", "visible": false } ],
                ["${var.metric_namespace}", "images.analyzed.count", "roomType", "En ukjent rom type", { "id": "m5", "visible": false } ]
            ],
            "period": 300,
            "stat": "Sum",
            "region": "${var.region}",
            "title": "Gjennomsnittlig antall genererte gaveforslag per bilde"
        }
    },
    {
        "type": "metric",
        "x": 0,
        "y": 6,
        "width": 12,
        "height": 6,
        "properties": {
            "metrics": [
                ["${var.metric_namespace}", "rekognition.detectLabels.avg", "class", "no.pgr301.exam.service.RekognitionService", "exception", "none", "method", "detectLabels"],
                ["${var.metric_namespace}", "bedrock.suggestGifts.avg", "class", "no.pgr301.exam.service.BedrockService", "exception", "none", "method", "suggestGifts"]
            ],
            "period": 300,
            "stat": "Average",
            "region": "${var.region}",
            "title": "Gjennomsnittlig responstid for Rekognition og Bedrock i ms"
        }
    },
    {
        "type": "metric",
        "x": 12,
        "y": 6,
        "width": 12,
        "height": 6,
        "properties": {
            "metrics": [
                ["AWS/ECS", "CPUUtilization", "ClusterName", "default", "ServiceName", "${aws_ecs_express_gateway_service.app.service_name}"],
                ["AWS/ECS", "MemoryUtilization", "ClusterName", "default", "ServiceName", "${aws_ecs_express_gateway_service.app.service_name}"]
            ],
            "period": 300,
            "stat": "Average",
            "region": "${var.region}",
            "title": "ECS CPU og minnebruk i %"
        }
    },
    {
        "type": "metric",
        "x": 0,
        "y": 12,
        "width": 12,
        "height": 6,
        "properties": {
            "metrics": [
                ["${var.metric_namespace}", "http.server.requests.avg", "error", "none", "exception", "none", "method", "POST", "outcome", "SUCCESS", "status", "200", "uri", "/api/analyze"]
            ],
            "period": 300,
            "stat": "Average",
            "region": "${var.region}",
            "title": "Responstid for /api/analyze endpoint"
        }
    }
  ]
}
DASHBOARD
}