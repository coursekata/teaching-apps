# ============================================================
#  survey.R
#  Hosted on GitHub. Source this file from your notebook.
#
#  To update questions or the endpoint, edit this file.
#  The notebook cell never needs to change.
# ============================================================

library(IRdisplay)

# ── 1. Configuration ─────────────────────────────────────────
APPS_SCRIPT_URL <- "https://script.google.com/macros/s/AKfycbxkVOeFVJY-t0UBdoVbz7IB_IDWzoNc8BSuk8PcpH85Z3tEzL4Uz0Dlio7KvhIF9GKVdA/exec"

questions <- list(
  list(id = "name",        label = "What is your name?"),
  list(id = "institution", label = "Your institution?"),
  list(id = "email",       label = "What is your email?"),
  list(id = "comments",    label = "Something else?")
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
    max-width: 480px;
    padding: 24px;
    border: 1px solid #e0e0e0;
    border-radius: 10px;
    background: #ffffff;
    box-shadow: 0 2px 8px rgba(0,0,0,0.07);
  }
  .survey-wrap h3 { margin: 0 0 18px 0; font-size: 17px; color: #202124; }
  .field { margin-bottom: 16px; }
  .field label {
    display: block; font-size: 13px; font-weight: 600;
    color: #3c4043; margin-bottom: 5px;
  }
  .field input {
    width: 100%%; padding: 9px 11px; box-sizing: border-box;
    border: 1px solid #dadce0; border-radius: 6px;
    font-size: 14px; color: #202124; outline: none;
    transition: border-color 0.15s;
  }
  .field input:focus {
    border-color: #4285f4;
    box-shadow: 0 0 0 2px rgba(66,133,244,0.15);
  }
  .survey-btn {
    background: #4285f4; color: #fff; border: none;
    padding: 10px 26px; border-radius: 6px;
    font-size: 14px; font-weight: 500; cursor: pointer;
    margin-top: 4px; transition: background 0.15s;
  }
  .survey-btn:hover:not(:disabled) { background: #3367d6; }
  .survey-btn:disabled { background: #9aa0a6; cursor: default; }
  #survey-status { margin-top: 13px; font-size: 13px; min-height: 18px; }
</style>

<div class="survey-wrap">
  <h3>&#128203; Quick Survey</h3>
  %s
  <button class="survey-btn" onclick="submitSurvey()">Submit</button>
  <div id="survey-status"></div>
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
      status.style.color = "#f29900";
      status.textContent = "Please fill in all fields before submitting.";
      return;
    }
    params.append(id, val);
  }

  params.append("timestamp", new Date().toISOString());

  // Send field order so Apps Script writes columns in the right sequence
  params.append("_fields", ids.join(","));

  // Show success immediately — do not wait for Apps Script cold start
  status.style.color = "#1e8e3e";
  status.textContent = "\u2713 Thank you! Your response has been recorded.";
  btn.disabled = true;
  ids.forEach(id => document.getElementById(id).disabled = true);

  // Fire and forget — request completes in the background
  fetch("%s", { method: "POST", mode: "no-cors", body: params }).catch(() => {});
}
</script>
  ', fields_html, ids_js, endpoint)
}

# ── 3. Render immediately on source() ────────────────────────
display_html(.build_survey_html(questions, APPS_SCRIPT_URL))
