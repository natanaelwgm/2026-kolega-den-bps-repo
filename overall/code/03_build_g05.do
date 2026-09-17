do "$OVERALL_REPO/overall/code/06_g0_summaries.do"
demo_progress "G0.5" "BUILD NEW DEVELOPMENT VALUES AND FICTIONAL PANEL FROM THIS RUN'S G0"
demo_shell "$OVERALL_PYTHON" "$OVERALL_REPO/overall/scripts/overall.py" development "$OVERALL_RUN" "$OVERALL_SEED"
if $DEMO_HELPER_RC!=0 exit $DEMO_HELPER_RC
confirm file "$OVERALL_RUN/g05/build-receipt.json"
