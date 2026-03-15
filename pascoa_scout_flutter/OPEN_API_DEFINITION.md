{
  "openapi": "3.0.1",
  "info": {
    "title": "Upwork Job Scraper",
    "description": "Scrape Upwork jobs without limits 🌟 Bypass CAPTCHAs & apply custom filters.\n\nApify is retiring rental Actors, so pricing is changing. For many users around ~7k jobs/month, cost should stay near the old $25. You still get the same no-cookie setup, with in-house Upwork accounts and proxies built in.",
    "version": "0.0",
    "x-build-id": "EVCMriLhfQGzaey1E"
  },
  "servers": [
    {
      "url": "https://api.apify.com/v2"
    }
  ],
  "paths": {
    "/acts/neatrat~upwork-job-scraper/run-sync-get-dataset-items": {
      "post": {
        "operationId": "run-sync-get-dataset-items-neatrat-upwork-job-scraper",
        "x-openai-isConsequential": false,
        "summary": "Executes an Actor, waits for its completion, and returns Actor's dataset items in response.",
        "tags": [
          "Run Actor"
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/inputSchema"
              }
            }
          }
        },
        "parameters": [
          {
            "name": "token",
            "in": "query",
            "required": true,
            "schema": {
              "type": "string"
            },
            "description": "Enter your Apify token here"
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    },
    "/acts/neatrat~upwork-job-scraper/runs": {
      "post": {
        "operationId": "runs-sync-neatrat-upwork-job-scraper",
        "x-openai-isConsequential": false,
        "summary": "Executes an Actor and returns information about the initiated run in response.",
        "tags": [
          "Run Actor"
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/inputSchema"
              }
            }
          }
        },
        "parameters": [
          {
            "name": "token",
            "in": "query",
            "required": true,
            "schema": {
              "type": "string"
            },
            "description": "Enter your Apify token here"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/runsResponseSchema"
                }
              }
            }
          }
        }
      }
    },
    "/acts/neatrat~upwork-job-scraper/run-sync": {
      "post": {
        "operationId": "run-sync-neatrat-upwork-job-scraper",
        "x-openai-isConsequential": false,
        "summary": "Executes an Actor, waits for completion, and returns the OUTPUT from Key-value store in response.",
        "tags": [
          "Run Actor"
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/inputSchema"
              }
            }
          }
        },
        "parameters": [
          {
            "name": "token",
            "in": "query",
            "required": true,
            "schema": {
              "type": "string"
            },
            "description": "Enter your Apify token here"
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "inputSchema": {
        "type": "object",
        "properties": {
          "query": {
            "title": "Search Query",
            "type": "string",
            "description": "Keywords to search for in Upwork jobs"
          },
          "rawUrl": {
            "title": "Raw URL",
            "type": "string",
            "description": "Directly use this Upwork search URL instead of constructing one (must be from upwork.com and include nx/search/jobs)"
          },
          "experienceLevel": {
            "title": "Experience Level",
            "type": "array",
            "description": "Filter jobs by required experience level",
            "items": {
              "type": "string"
            }
          },
          "jobType": {
            "title": "Job Type",
            "type": "array",
            "description": "Filter jobs by payment type",
            "items": {
              "type": "string"
            }
          },
          "paymentVerified": {
            "title": "Payment Verified",
            "type": "boolean",
            "description": "Filter jobs by payment verification status"
          },
          "fixedPriceRange": {
            "title": "Fixed Price Range",
            "minItems": 2,
            "maxItems": 2,
            "type": "array",
            "description": "Range for fixed-price jobs (min and max in USD, e.g. [100, 1000])",
            "items": {
              "type": "string"
            }
          },
          "hourlyRateRange": {
            "title": "Hourly Rate Range",
            "minItems": 2,
            "maxItems": 2,
            "type": "array",
            "description": "Range for hourly rate jobs (min and max in USD/hour, e.g. [20, 50])",
            "items": {
              "type": "string"
            }
          },
          "clientHistory": {
            "title": "Client History",
            "type": "array",
            "description": "Filter by client hiring history",
            "items": {
              "type": "string"
            }
          },
          "location": {
            "title": "Location",
            "type": "array",
            "description": "Filter jobs by location (regions, subregions, or countries)",
            "items": {
              "type": "string"
            }
          },
          "cookies": {
            "title": "Cookies",
            "type": "array",
            "description": "Cookies to use for requests (useful for bypassing Upwork's protection)"
          },
          "customFilters": {
            "title": "Custom Filters",
            "type": "array",
            "description": "Custom filters to apply to job results"
          },
          "page": {
            "title": "Page Number",
            "minimum": 1,
            "type": "integer",
            "description": "Page number to start scraping from",
            "default": 1
          },
          "pagesToScrape": {
            "title": "Pages to Scrape",
            "minimum": 1,
            "type": "integer",
            "description": "Number of pages to scrape sequentially starting from the specified page",
            "default": 1
          },
          "perPage": {
            "title": "Results Per Page",
            "minimum": 10,
            "type": "integer",
            "description": "Number of results to display per page",
            "default": 10
          },
          "sort": {
            "title": "Sort Order",
            "enum": [
              "newest",
              "relevance"
            ],
            "type": "string",
            "description": "How to sort the job listings",
            "default": "newest"
          },
          "maxJobAge": {
            "title": "Maximum Job Age",
            "type": "object",
            "description": "Filter out jobs older than this time"
          }
        }
      },
      "runsResponseSchema": {
        "type": "object",
        "properties": {
          "data": {
            "type": "object",
            "properties": {
              "id": {
                "type": "string"
              },
              "actId": {
                "type": "string"
              },
              "userId": {
                "type": "string"
              },
              "startedAt": {
                "type": "string",
                "format": "date-time",
                "example": "2025-01-08T00:00:00.000Z"
              },
              "finishedAt": {
                "type": "string",
                "format": "date-time",
                "example": "2025-01-08T00:00:00.000Z"
              },
              "status": {
                "type": "string",
                "example": "READY"
              },
              "meta": {
                "type": "object",
                "properties": {
                  "origin": {
                    "type": "string",
                    "example": "API"
                  },
                  "userAgent": {
                    "type": "string"
                  }
                }
              },
              "stats": {
                "type": "object",
                "properties": {
                  "inputBodyLen": {
                    "type": "integer",
                    "example": 2000
                  },
                  "rebootCount": {
                    "type": "integer",
                    "example": 0
                  },
                  "restartCount": {
                    "type": "integer",
                    "example": 0
                  },
                  "resurrectCount": {
                    "type": "integer",
                    "example": 0
                  },
                  "computeUnits": {
                    "type": "integer",
                    "example": 0
                  }
                }
              },
              "options": {
                "type": "object",
                "properties": {
                  "build": {
                    "type": "string",
                    "example": "latest"
                  },
                  "timeoutSecs": {
                    "type": "integer",
                    "example": 300
                  },
                  "memoryMbytes": {
                    "type": "integer",
                    "example": 1024
                  },
                  "diskMbytes": {
                    "type": "integer",
                    "example": 2048
                  }
                }
              },
              "buildId": {
                "type": "string"
              },
              "defaultKeyValueStoreId": {
                "type": "string"
              },
              "defaultDatasetId": {
                "type": "string"
              },
              "defaultRequestQueueId": {
                "type": "string"
              },
              "buildNumber": {
                "type": "string",
                "example": "1.0.0"
              },
              "containerUrl": {
                "type": "string"
              },
              "usage": {
                "type": "object",
                "properties": {
                  "ACTOR_COMPUTE_UNITS": {
                    "type": "integer",
                    "example": 0
                  },
                  "DATASET_READS": {
                    "type": "integer",
                    "example": 0
                  },
                  "DATASET_WRITES": {
                    "type": "integer",
                    "example": 0
                  },
                  "KEY_VALUE_STORE_READS": {
                    "type": "integer",
                    "example": 0
                  },
                  "KEY_VALUE_STORE_WRITES": {
                    "type": "integer",
                    "example": 1
                  },
                  "KEY_VALUE_STORE_LISTS": {
                    "type": "integer",
                    "example": 0
                  },
                  "REQUEST_QUEUE_READS": {
                    "type": "integer",
                    "example": 0
                  },
                  "REQUEST_QUEUE_WRITES": {
                    "type": "integer",
                    "example": 0
                  },
                  "DATA_TRANSFER_INTERNAL_GBYTES": {
                    "type": "integer",
                    "example": 0
                  },
                  "DATA_TRANSFER_EXTERNAL_GBYTES": {
                    "type": "integer",
                    "example": 0
                  },
                  "PROXY_RESIDENTIAL_TRANSFER_GBYTES": {
                    "type": "integer",
                    "example": 0
                  },
                  "PROXY_SERPS": {
                    "type": "integer",
                    "example": 0
                  }
                }
              },
              "usageTotalUsd": {
                "type": "number",
                "example": 0.00005
              },
              "usageUsd": {
                "type": "object",
                "properties": {
                  "ACTOR_COMPUTE_UNITS": {
                    "type": "integer",
                    "example": 0
                  },
                  "DATASET_READS": {
                    "type": "integer",
                    "example": 0
                  },
                  "DATASET_WRITES": {
                    "type": "integer",
                    "example": 0
                  },
                  "KEY_VALUE_STORE_READS": {
                    "type": "integer",
                    "example": 0
                  },
                  "KEY_VALUE_STORE_WRITES": {
                    "type": "number",
                    "example": 0.00005
                  },
                  "KEY_VALUE_STORE_LISTS": {
                    "type": "integer",
                    "example": 0
                  },
                  "REQUEST_QUEUE_READS": {
                    "type": "integer",
                    "example": 0
                  },
                  "REQUEST_QUEUE_WRITES": {
                    "type": "integer",
                    "example": 0
                  },
                  "DATA_TRANSFER_INTERNAL_GBYTES": {
                    "type": "integer",
                    "example": 0
                  },
                  "DATA_TRANSFER_EXTERNAL_GBYTES": {
                    "type": "integer",
                    "example": 0
                  },
                  "PROXY_RESIDENTIAL_TRANSFER_GBYTES": {
                    "type": "integer",
                    "example": 0
                  },
                  "PROXY_SERPS": {
                    "type": "integer",
                    "example": 0
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}