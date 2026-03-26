# ============================================================
#  survey.R
#  Hosted on GitHub. Source this file from your notebook.
#
#  To update questions or the endpoint, edit this file.
#  The notebook cell never needs to change.
# ============================================================

library(IRdisplay)

# ── 1. Configuration ─────────────────────────────────────────
APPS_SCRIPT_URL <- "https://script.google.com/macros/s/AKfycbzTwtNjTqCbKnA74WFGRiy6Hc12gbjpyDRvEUUR8vAcLHFge9_rNf_kpzJPc5K_Ns-qFQ/exec"

questions <- list(
  list(id = "name",        label = "Name"),
  list(id = "institution", label = "Institution"),
  list(id = "email",       label = "Email"),
  list(id = "comments",    label = "Comments")
)

# ── 2. HTML Builder ───────────────────────────────────────────
.build_survey_html <- function(questions, endpoint) {

  fields_html <- paste(sapply(questions, function(q) {
    sprintf('
      <div class="field">
        <label for="%s">%s</label>
        <input type="text" id="%s" name="%s" autocomplete="off" />
      </div>',
      q$id, q$label, q$id, q$id)
  }), collapse = "\n")


  ids_js <- sprintf('["%s"]',
    paste(sapply(questions, `[[`, "id"), collapse = '","'))

  sprintf('
<style>
  .survey-wrap {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
    max-width: 600px;
    padding: 16px;
    border: 1px solid #e0e0e0;
    border-radius: 6px;
    background: #ffffff;
  }
  .survey-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 10px 16px;
    margin-bottom: 12px;
  }
  .field label {
    display: block;
    font-size: 12px;
    color: #666;
    margin-bottom: 3px;
    font-weight: normal;
  }
  .field input {
    width: 100%%;
    padding: 7px 9px;
    box-sizing: border-box;
    border: 1px solid #d0d0d0;
    border-radius: 4px;
    font-size: 13px;
    color: #202124;
    outline: none;
    background: #fafafa;
    transition: border-color 0.15s, background 0.15s;
  }
  .field input:focus {
    border-color: #888;
    background: #fff;
  }
  .survey-btn {
    background: none;
    color: #444;
    border: 1px solid #aaa;
    padding: 7px 20px;
    border-radius: 4px;
    font-size: 13px;
    cursor: pointer;
    transition: border-color 0.15s, color 0.15s;
  }
  .survey-btn:hover:not(:disabled) {
    border-color: #444;
    color: #111;
  }
  .survey-btn:disabled {
    color: #aaa;
    border-color: #ddd;
    cursor: default;
  }
  #survey-status {
    display: inline-block;
    margin-left: 12px;
    font-size: 12px;
    color: #666;
    vertical-align: middle;
  }
</style>

<div class="survey-wrap">
  <div class="survey-grid">
    %s
  </div>
  <button class="survey-btn" onclick="submitSurvey()">Submit</button>
  <span id="survey-status"></span>
</div>

<script>
async function submitSurvey() {
  const ids    = %s;
  const status = document.getElementById("survey-status");
  const btn    = document.querySelector(".survey-btn");
  const params = new URLSearchParams();

  for (const id of ids) {
    const val = document.getElementById(id).value.trim();
    if (!val) {
      status.style.color = "#b45000";
      status.textContent = "Please fill in all fields.";
      return;
    }
    params.append(id, val);
  }

  params.append("timestamp", new Date().toISOString());
  params.append("_fields", ids.join(","));

  btn.disabled = true;
  ids.forEach(id => document.getElementById(id).disabled = true);

  fetch("%s", { method: "POST", mode: "no-cors", body: params }).catch(() => {});

  status.style.color = "#1e8e3e";
  status.textContent = "\u2713 Recorded. Thank you.";
}
</script>
  ', fields_html, ids_js, endpoint)
}

# ── 3. Render immediately on source() ────────────────────────
display_html(.build_survey_html(questions, APPS_SCRIPT_URL))
