{{- define "datrics.aiAnalyst.env_vars" -}}
- name: DB_URL
  value: {{ include "datrics.aiAnalystDbConnectionAsync" . | quote }}
- name: CELERY_BACKEND
  value: {{ include "datrics.aiAnalystDbConnectionCelery" . | quote }}
- name: BACKEND_DB_URl
  value: {{ include "datrics.backendDbConnectionAsync" . | quote }}
- name: OPENAI_API_KEY
  value: {{ .Values.common.llm.openai_api_key | quote }}
- name: AZURE_ENDPOINT
  value: {{ .Values.common.llm.azure_endpoint | quote }}
- name: API_TYPE
  value: {{ .Values.common.llm.api_type | quote }}
- name: AZURE_DEPLOYMENT
  value: {{ .Values.common.llm.azure_deployment | quote }}
- name: AZURE_OPENAI_VERSION
  value: {{ .Values.common.llm.azure_openai_version | quote }}
- name: LANGCHAIN_API_KEY
  value: {{ .Values.common.langchain.api_key | quote }}
- name: LANGCHAIN_TRACING_V2
  value: {{ .Values.common.langchain.tracing_enabled | quote }}
- name: LANGCHAIN_ENDPOINT
  value: {{ .Values.common.langchain.endpoint | quote }}
- name: REDIS_URL
  value: {{ include "datrics.redisUrl" . | quote }}
- name: USE_STORAGE
  value: {{ .Values.aiAnalyst.config.storage.enabled | quote }}
- name: STORAGE_HOST
  value: {{ (printf "%s:%s" (include "datrics.minioHost" .) (include "datrics.minioPort" .)) | quote }}
- name: STORAGE_ACCESS_KEY
  value: {{ include "datrics.minioAccessKey" . | quote }}
- name: STORAGE_SECRET_KEY
  value: {{ include "datrics.minioSecretKey" . | quote }}
- name: STORAGE_IS_SECURE
  value: {{ include "datrics.minioUseSSL" . | quote }}
- name: STORAGE_BUCKET
  value: {{ include "datrics.minioBucket" . | quote }}
- name: BASE_URL
  value: {{ include "datrics.aiAnalystEndpoint" . | quote }}
- name: BACKEND_API
  value: {{ include "datrics.apiEndpoint" . }}/api/v1/deploymentsV3
{{- end -}}