{{- define "datrics.previewer.env_vars" -}}
- name: MINIO_HOST_URL
  value: {{ (printf "%s:%s" (include "datrics.minioHost" .) (include "datrics.minioPort" .)) | quote }}
- name: MINIO_HOST_IS_SECURE
  value: {{ include "datrics.minioUseSSL" . | quote }}
- name: MINIO_ACCESS_KEY
  value: {{ include "datrics.minioAccessKey" . | default .Values.minio.rootUser | quote }}
- name: MINIO_SECRET_KEY
  value: {{ include "datrics.minioSecretKey" . | default .Values.minio.rootPassword | quote }}
- name: CACHE_REDIS_ENABLED
  value: {{ .Values.previewer.config.redis_cache_enabled | quote }}
- name: FS_CACHE_DIR
  value: {{ .Values.previewer.config.fs_cache_dir | quote }}
- name: CACHE_ENABLED
  value: {{ .Values.previewer.config.cache_enabled | quote }}
{{- end -}}