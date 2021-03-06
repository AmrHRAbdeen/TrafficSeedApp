#!/bin/bash
set -e
# Cleanup Script
# Authors: GE SDLP 2015
#
currentDirectory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
logDirectory="$currentDirectory/.."

source "$currentDirectory/variables.sh"
source "$currentDirectory/files_helper_funcs.sh"
source "$currentDirectory/error_handling_funcs.sh"

touch "$logDirectory/quickstartlog.log"

# Unbind any possible services
# *****************************
__append_new_line_log "######## CLEAN UP IN PROGRESS ########" "$logDirectory"

if cf us $TEMP_APP $REDIS_INSTANCE_NAME; then
  __append_new_line_log "Successfully unbinded \"$REDIS_INSTANCE_NAME\" from \"$TEMP_APP\"" "$logDirectory"
else
  __append_new_line_log "Failed to delete. $TEMP_APP might not exist" "$logDirectory"
fi

if cf us $FRONT_END_APP_NAME $REDIS_INSTANCE_NAME; then
  __append_new_line_log "Successfully unbinded \"$REDIS_INSTANCE_NAME\" from \"$FRONT_END_APP_NAME\"" "$logDirectory"
else
  __append_new_line_log "Failed to delete. $FRONT_END_APP_NAME might not exist" "$logDirectory"
fi

if cf us $TEMP_APP $IE_INSTANCE_NAME; then
  __append_new_line_log "Successfully unbinded \"$IE_INSTANCE_NAME\" from \"$TEMP_APP\"" "$logDirectory"
else
  __append_new_line_log "Failed to delete. $TEMP_APP might not exist" "$logDirectory"
fi

if cf us $FRONT_END_APP_NAME $IE_INSTANCE_NAME; then
  __append_new_line_log "Successfully unbinded \"$IE_INSTANCE_NAME\" from \"$FRONT_END_APP_NAME\"" "$logDirectory"
else
  __append_new_line_log "Failed to delete. $FRONT_END_APP_NAME might not exist" "$logDirectory"
fi

if cf us $TEMP_APP $UAA_INSTANCE_NAME; then
  __append_new_line_log "Successfully unbinded \"$UAA_INSTANCE_NAME\" from \"$TEMP_APP\"" "$logDirectory"
else
  __append_new_line_log "Failed to delete. $TEMP_APP might not exist" "$logDirectory"
fi

if cf us $FRONT_END_APP_NAME $UAA_INSTANCE_NAME; then
  __append_new_line_log "Successfully unbinded \"$UAA_INSTANCE_NAME\" from \"$FRONT_END_APP_NAME\"" "$logDirectory"
else
  __append_new_line_log "Failed to delete. $FRONT_END_APP_NAME might not exist" "$logDirectory"
fi

# Delete the applications
# *****************************

if cf d $FRONT_END_APP_NAME -f -r; then
  __append_new_line_log "Successfully deleted \"$FRONT_END_APP_NAME\"" "$logDirectory"
else
  __append_new_line_log "Failed to delete \"$FRONT_END_APP_NAME\". Retrying..." "$logDirectory"
  if cf d $FRONT_END_APP_NAME -f -r; then
    __append_new_line_log "Successfully deleted \"$FRONT_END_APP_NAME\"" "$logDirectory"
  else
    __append_new_line_log "Failed to delete \"$FRONT_END_APP_NAME\". Giving up." "$logDirectory"
  fi
fi

if cf d $TEMP_APP -f -r; then
  __append_new_line_log "Successfully deleted \"$TEMP_APP\"" "$logDirectory"
else
  __append_new_line_log "Failed to delete \"$TEMP_APP\". Retrying..." "$logDirectory"
  if cf d $TEMP_APP -f -r; then
    __append_new_line_log "Successfully deleted \"$TEMP_APP\"" "$logDirectory"
  else
    __append_new_line_log "Failed to delete \"$TEMP_APP\". Giving up." "$logDirectory"
  fi
fi

# Delete the services
# *****************************
if cf ds $UAA_INSTANCE_NAME -f; then
  __append_new_line_log "Successfully deleted \"$UAA_INSTANCE_NAME\"" "$logDirectory"
else
  __append_new_line_log "Failed to delete \"$UAA_INSTANCE_NAME\". Retrying..." "$logDirectory"
  if cf d $UAA_INSTANCE_NAME -f -r; then
    __append_new_line_log "Successfully deleted \"$UAA_INSTANCE_NAME\"" "$logDirectory"
  else
    __append_new_line_log "Failed to delete \"$UAA_INSTANCE_NAME\". Giving up." "$logDirectory"
  fi
fi

if cf ds $REDIS_INSTANCE_NAME -f; then
  __append_new_line_log "Successfully deleted \"$REDIS_INSTANCE_NAME\"" "$logDirectory"
else
  __append_new_line_log "Failed to delete \"$REDIS_INSTANCE_NAME\". Retrying..." "$logDirectory"
  if cf d $REDIS_INSTANCE_NAME -f -r; then
    __append_new_line_log "Successfully deleted \"$REDIS_INSTANCE_NAME\"" "$logDirectory"
  else
    __append_new_line_log "Failed to delete \"$REDIS_INSTANCE_NAME\". Giving up." "$logDirectory"
  fi
fi

if cf ds $IE_INSTANCE_NAME -f; then
  __append_new_line_log "Successfully deleted \"$IE_INSTANCE_NAME\"" "$logDirectory"
else
  __append_new_line_log "Failed to delete \"$IE_INSTANCE_NAME\". Retrying..." "$logDirectory"
  if cf d $IE_INSTANCE_NAME -f -r; then
    __append_new_line_log "Successfully deleted \"$IE_INSTANCE_NAME\"" "$logDirectory"
  else
    __append_new_line_log "Failed to delete \"$IE_INSTANCE_NAME\". Giving up." "$logDirectory"
  fi
fi

__append_new_line_log "######## CLEAN UP COMPLETE ########" "$logDirectory"
