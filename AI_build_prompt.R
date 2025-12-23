# ============================================================
# NCDAI Study - AI Prompt Construction (Demonstration Only)
# ============================================================
# This script documents the logic used to assemble AI prompts
# for clinical decision support in hypertension and diabetes.
# No real patient data are used.
# ============================================================


# ---------------------------
# 1. System / Context Prompt
# ---------------------------
get_context_prompt <- function() {
  
  paste(
    "You are an advanced Clinical Decision Support Assistant.",
    "Enhance healthcare professionals' decision-making using evidence-based clinical guidelines only.",
    "Apply Retrieval Augmented Generation (RAG) exclusively from authorized clinical guidelines and textbooks.",
    "Summarize patient data, stratify risks, generate differential diagnoses, and propose actionable interventions.",
    "Adhere to clinical safety standards and ethical considerations.",
    "Acknowledge system limitations.",
    "Maintain a concise, professional tone.",
    "Do not introduce external information or personal opinions.",
    sep = "\n"
  )
}


# --------------------------------
# 2. Synthetic Patient Data Block
# --------------------------------
get_example_patient_blocks <- function() {
  
  paste(
    "Patient details (synthetic example):",
    "Demographics: 55-year-old male",
    "Medical history: Hypertension, Type 2 Diabetes Mellitus",
    "Lifestyle factors: Sedentary, non-smoker, moderate salt intake",
    "Clinical examination: Blood pressure 150/95 mmHg, BMI 29 kg/m²",
    "Laboratory results: HbA1c 8.2%, LDL 3.4 mmol/L, eGFR 68 mL/min/1.73m²",
    "Risk assessment: High cardiovascular risk",
    "Current management plan: Metformin 1000 mg BID, Amlodipine 5 mg OD",
    sep = "\n"
  )
}


# -------------------------------------
# 3. Task-Specific Prompt Modules
# -------------------------------------
get_task_modules <- function(selected_options) {
  
  modules <- character()
  
  if ("Dosage recommendations" %in% selected_options) {
    modules <- c(
      modules,
      paste(
        "Review diagnostic tests and identify any investigations that may need to be revisited or added.",
        "Suggest specific tests to assess complications of hypertension or diabetes.",
        "Provide medication dosage recommendations, including dose, frequency, and monitoring considerations.",
        sep = "\n"
      )
    )
  }
  
  if ("Personalized Medication Recommendations" %in% selected_options) {
    modules <- c(
      modules,
      paste(
        "Provide personalized medication recommendations considering patient comorbidities,",
        "risk factors, and lifestyle characteristics.",
        "Highlight potential dosage adjustments and monitoring for adverse effects or interactions.",
        sep = "\n"
      )
    )
  }
  
  if ("Adherence to Evidence-Based Guidelines" %in% selected_options) {
    modules <- c(
      modules,
      "Verify whether the current management aligns with the latest evidence-based guidelines for hypertension and diabetes. Suggest updates if discrepancies are identified."
    )
  }
  
  if ("Proactive Treatment Adjustments" %in% selected_options) {
    modules <- c(
      modules,
      "Identify opportunities for proactive treatment adjustments or early interventions to prevent complications."
    )
  }
  
  if ("Patient-Specific Risk Stratification" %in% selected_options) {
    modules <- c(
      modules,
      "Provide a detailed patient-specific risk stratification, including cardiovascular and renal risk, with tailored intervention recommendations."
    )
  }
  
  modules
}


# -------------------------------------
# 4. Main Prompt Assembly Function
# -------------------------------------
build_prompt <- function(
    patient_blocks,
    selected_options = NULL
) {
  
  # Input validation
  if (is.null(patient_blocks) || !is.character(patient_blocks)) {
    stop("patient_blocks must be provided as a character string.")
  }
  
  if (is.null(selected_options) || length(selected_options) == 0) {
    selected_options <- c(
      "Dosage recommendations",
      "Personalized Medication Recommendations",
      "Adherence to Evidence-Based Guidelines"
    )
  }
  
  context_prompt <- get_context_prompt()
  task_modules  <- get_task_modules(selected_options)
  
  closing_statement <- "If additional information is required or if findings appear unusual, ask appropriate follow-up questions."
  
  paste(
    c(
      context_prompt,
      patient_blocks,
      task_modules,
      closing_statement
    ),
    collapse = "\n\n"
  )
}

# --------------------------------------
# 5. Create the 'examples' folder
# --------------------------------------
dir.create("examples", showWarnings = FALSE)

# --------------------------------------
# 6. Generate the final prompt
# --------------------------------------
# Assuming you have build_prompt() and get_example_patient_blocks() defined
example_patient_blocks <- get_example_patient_blocks()

final_prompt <- build_prompt(
  patient_blocks = example_patient_blocks,
  selected_options = c(
    "Dosage recommendations",
    "Adherence to Evidence-Based Guidelines",
    "Patient-Specific Risk Stratification"
  )
)

# --------------------------------------
# 7. Save the prompt as a Markdown file
# --------------------------------------
output_file <- "examples/example_prompt_output.md"

writeLines(
  paste0("```\n", final_prompt, "\n```"), 
  con = output_file
)

cat("Example prompt saved to:", output_file, "\n")
