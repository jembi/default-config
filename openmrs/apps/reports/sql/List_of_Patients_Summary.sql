SELECT
@rownum:=(@rownum + 1) AS 'No',
global_table.NID AS 'Processo-NID',
Nome AS 'Processo-Nome',
kpop AS 'População Chave',
vul_pop AS 'População Vulnerável (Especifique)',
DATE_FORMAT(encounter_datetime, '%d-%m-%Y') AS '1. Consulta Atual / Outros (d-m-a)',
next_cons AS '1. Próxima Consulta (d/m/a)',
age AS '2. Idade (Se > 5 anos-em anos; Se ≤ 5 anos - em meses)',
CONCAT(COALESCE(sistolic, '-'),
'/',
COALESCE(diastolic, '-')) AS '2. Tensão Arterial',
CONCAT(COALESCE(pregnancy_status, '-'),
'/',
COALESCE(menstruation_date, '-'),
'/',
COALESCE(bfeeding, '-')) AS '3. Gravidez/ Data Última Menstruaç/Lactante (G -Data DUM/ L)',
CONCAT(COALESCE(fp_condom,''),COALESCE(fam_planning,''),COALESCE(tubal_ligation,''),COALESCE(amenorreia_method,''),COALESCE(fp_other_method,'')) AS '3. Plan. Familiar (Não/ Método)',
WHO AS '4. Estadio OMS (I,II,III,IV)',
edemas AS '4. Criança - Edemas (0/ + a +++)',
weight AS '5. Peso (kg)',
height AS '5. Comprimento/ Altura (Se > 5 anos - em metros; Se ≤ 5 anos - em cm)',
PB AS '6. PB (Grávida; 6 meses do Pós- Parto; Criança6-59 meses)',
IMC AS '6. IMC (Kg/m2)',
'' AS '7. Avaliação Nutricional -Indicador(IMC; PB; IMC/Idade; P/E)',
nut_eval AS '7. Avaliação Nutricional - Grau (Normal/ Ligeira/ DAM/ DAG)',
CONCAT(COALESCE(nut_ed_received, '-'),
'/',
COALESCE(nutritional_supplements, '-')) AS '8. Recebeu apoio/ educação nutricional (Não/Tipo)',
quantidade AS '8. Quantidade',
got_symptoms AS '9. TB Tem sintomas? (S/N)',
list_of_symptoms AS '9. TB Quais sintomas? (FESTAC; adenopatias)',
TB_diagosis_date AS '10. Diagnóstico TB activa (S/ N)',
CONCAT(COALESCE(TB_start, '-'),
'/',
COALESCE(TB_state, '-'),
'/',
COALESCE(TB_end, '-')) AS '10. Tratamento TB (Cartão TB -Data de Inicio e Fim) (Início/ Continua/ Fim) (d/m/a- I/C/F)',
CONCAT(COALESCE(prophylaxis_start, '-'),
'/',
COALESCE(prophilaxis_state, '-'),
'/',
COALESCE(prophylaxis_end, '-')) AS '11. Profilaxia INH (Inicio/Continua/Fim - I/C/F)',
CONCAT(COALESCE(CTZ_prophylaxis_start, '-'),
'/',
COALESCE(CTZ_prophilaxis_state, '-'),
'/',
COALESCE(CTZ_prophylaxis_end, '-')) AS '11. Profilaxia CTZ (Inicio/Continua/Fim - I/C/F)',
SEF_INH AS '12. INH Ef. Secundários  (S/ N)',
SEF_CTZ AS '12. CTZ Ef. Secundarios (S/N)',
its_symptoms AS '13. ITS Tem sintomas? (S/N)',
synd_appr_female AS '13. ITS Diagnóstico ITS (Código)',
infects AS '14. Infeções oportunistas, incluindo Sarcoma Kaposi, Outras doenças (Não/ Diagnóstico)',
test_requests AS '15. Exames Pedidos',
laboratory_results AS '16. Exames Resultados',
line_dispense AS '17. Linha - Dispensa mensal/ trimestral (1.ª/ 2.ª/ 3.ª Linha - DM/ DT/DS)',
drugs_regime AS '17. Regime (siglas)',
regime_frequency AS '18. Para cada ARV Posologia de cada dose e N.º de doses/dia',
'' AS '19. Alternativa ou Mudança linha? (Não/A - M)',
'' AS '19. Motivo (Código)',
'' AS '20. Efeitos Secundários (Não/Código - Grau)',
'' AS '20. Adesão (Boa/ Risco/ Má -B/ R/ M)',
p_state AS '21. Mudança Estado Permanência TARV ( R S A O T)',
'' AS '22. Outras prescrições (Excluir TPI, TPC eARVs)',
c_services AS '23. Referência - TB/ PTV/PF/APSS e PP/Revelação diagnóstica/Internamento/Outro',
grupo_apoio_list AS '24. Referência - Grupo Apoio (Código)',
'' AS '24. Referência - Grupo Apoio Elegível(S/ N)',
grupo_apoio AS '24. Referência - Grupo Apoio Início/ Continua/ Fim (I/ C/ F)',
mdc_code AS '24. Referência - Modelo Diferenciado Cuidados (MDC)(Código)',
eligibility_mdc AS '24. Referência - Modelo Diferenciado Cuidados (MDC) Elegível(S/ N)',
mdc_states AS '24. Referência - Modelo Diferenciado Cuidados (MDC) Início/ Continua/ Fim (I/ C/ F)',
provider AS '25. Provedor'
FROM
    (SELECT @rownum:=0) AS initialization,
(SELECT
 NID,Nome, encounter_datetime,next_cons,age, MAX(diastolic) AS diastolic, MAX(sistolic) AS sistolic,
 MAX(pregnancy_status) AS pregnancy_status,MAX(bfeeding) AS bfeeding, MAX(menstruation_date) AS menstruation_date, MAX(WHO) AS WHO, MAX(condom_value) AS condom_value,
 MAX(weight) AS weight, MAX(altura) AS height, MAX(PB) AS PB, MAX(IMC) AS IMC, MAX(nut_eval) nut_eval, MAX(edemas) edemas, MAX(nut_ed_received) AS nut_ed_received, MAX(nutritional_supplements) AS nutritional_supplements,
 MAX(quantidade) AS quantidade, MAX(got_symptoms) AS got_symptoms, MAX(list_of_symptoms) AS list_of_symptoms, MAX(TB_diagosis_date) AS TB_diagosis_date, MAX(TB_start) AS TB_start, MAX(TB_end) AS TB_end,
 MAX(TB_state) AS TB_state,MAX(prophilaxis_state) AS prophilaxis_state, MAX(CTZ_prophilaxis_state) AS CTZ_prophilaxis_state, MAX(prophylaxis_start) AS prophylaxis_start, MAX(prophylaxis_end) AS prophylaxis_end,
 MAX(CTZ_prophylaxis_start) AS CTZ_prophylaxis_start, MAX(CTZ_prophylaxis_end) AS CTZ_prophylaxis_end,MAX(SEF_INH) AS SEF_INH, MAX(SEF_CTZ) AS SEF_CTZ, MAX(its_symptoms) AS its_symptoms, MAX(synd_appr_male) AS synd_appr_male,
 MAX(synd_appr_female) AS synd_appr_female, MAX(infects) AS infects, MAX(cv) AS cv, MAX(test_requests) AS test_requests,MAX(line_dispense) AS line_dispense, MAX(drugs_regime) AS drugs_regime, MAX(regime_frequency) AS regime_frequency,
 MAX(p_state) AS p_state, MAX(c_services) AS c_services, MAX(grupo_apoio) AS grupo_apoio,MAX(mdc_states) AS mdc_states,MAX(grupo_apoio_list) AS grupo_apoio_list,MAX(eligibility_mdc) AS eligibility_mdc,
 MAX(mdc_code) AS mdc_code,MAX(fam_planning) AS fam_planning,MAX(kpop) AS kpop,MAX(vul_pop) AS vul_pop, MAX(laboratory_results) AS laboratory_results,MAX(fp_condom) AS fp_condom, MAX(tubal_ligation) AS tubal_ligation,
 MAX(amenorreia_method) AS amenorreia_method,MAX(fp_other_method) AS fp_other_method, MAX(provider) AS provider,MAX(patient_id) AS patient_id, MAX(encounter_id) AS encounter_id
 FROM (SELECT DISTINCT
       obs.identifier AS NID,
       obs.full_name AS Nome,
       DATE(encounter_datetime) AS encounter_datetime,
       DATE_FORMAT(appointment.next_consultation,'%d-%m-%Y') AS next_cons,
       obs.age,
       diastolic.value_numeric AS diastolic,
       sistolic.value_numeric AS sistolic,
       pregnant AS pregnancy_status,
       breast_feeding_value AS bfeeding,
       DATE_FORMAT(date_of_menstruation.value_datetime, '%d-%m-%Y') AS menstruation_date,
       table_WHO_staging.name AS WHO,
       condom_value,
       weight.value_numeric AS weight,
       height.value_numeric AS altura,
       bperimeter.value_numeric AS PB,
       bmi.value_numeric AS IMC,
       nutritional_eval AS nut_eval,
       odema.odemas_value AS edemas,
       nutritional_education.received AS nut_ed_received,
       nutritional_supplement.supplement AS nutritional_supplements,
       suppl_quant.value_numeric AS quantidade,
       has_symptoms.symptoms_value AS got_symptoms,
       symptoms_list.symptoms AS list_of_symptoms,
       COALESCE(date_of_diagnosis.v_datetime, 'NÃO') AS TB_diagosis_date,
       DATE_FORMAT(date_of_TB_start.value_datetime, '%d-%m-%Y') AS TB_start,
       DATE_FORMAT(date_of_TB_end.value_datetime, '%d-%m-%Y') AS TB_end,
       state_of_TB.state AS TB_state,
       state_of_prophylaxis.state AS prophilaxis_state,
       state_of_prophylaxis_CTZ.state AS CTZ_prophilaxis_state,
       DATE_FORMAT(date_of_prophylaxis_start.value_datetime, '%d-%m-%Y') AS prophylaxis_start,
       DATE_FORMAT(date_of_prophylaxis_end.value_datetime, '%d-%m-%Y') AS prophylaxis_end,
       DATE_FORMAT(date_of_CTZ_prophylaxis_start.value_datetime, '%d-%m-%Y') AS CTZ_prophylaxis_start,
       DATE_FORMAT(date_of_CTZ_prophylaxis_end.value_datetime, '%d-%m-%Y') AS CTZ_prophylaxis_end,
       sec_efects.has_sec_efects AS SEF_INH,
       sec_efects_ctz.has_sec_efects_ctz AS SEF_CTZ,
       symptoms_of_its.has_its_symptoms AS its_symptoms,
       male_syndromic_appr.approach AS synd_appr_male,
       female_syndromic_appr.approach AS synd_appr_female,
       op_infections.infections AS infects,
       viral_load.value_numeric AS cv,
       lab_requests.lab_tests AS test_requests,
       line_dispense.LD AS line_dispense,
       drugs_regime.drugs AS drugs_regime,
       frqncy.freq AS regime_frequency,
       CONCAT('Activo em ', patient_state.patient_status) AS p_state,
       services_list.services AS c_services,
       gr_apoio.g_apoio_list AS grupo_apoio,
       table_mdc.states AS mdc_states,
       sg_list.list_sg AS grupo_apoio_list,
       mdc_eligibility.mdc_yes_no AS eligibility_mdc,
       mdc_table1.modelos_diferenciados AS mdc_code,
       fplanning.family_planning AS fam_planning,
       key_population.pop_chave AS kpop,
       vp.pop_vul AS vul_pop,
       gr_results.res AS laboratory_results,
       fpcond.fp_condom,
       fp_tubal_ligation.tubal_ligation,
       fp_amenorreia.amenorreia_method,
       fp_other.fp_other_method,
       prov.provider,
       obs.patient_id,
       obs.encounter_id
       FROM
       (SELECT
        identifier,
        person.person_id,
        full_name,
        date_created,
        encounter_datetime,
        TIMESTAMPDIFF(YEAR, person.birthdate, CURDATE()) AS age,
        encounter_id,
        patient_id
        FROM
        encounter
        INNER JOIN (SELECT identifier,
                   CONCAT(pn.given_name, ' ', COALESCE(pn.middle_name, ''), ' ', COALESCE(pn.family_name, '')) AS full_name,
                   pn.person_id,
                   p.birthdate
            FROM
            person_name pn
            JOIN patient_identifier pi ON pn.person_id = pi.patient_id AND pn.voided = 0 AND pi.voided = 0
            JOIN person p ON p.person_id = pn.person_id AND p.voided = 0
            left join
					(select p.person_id as personid
					from  person p
					INNER join obs ob1 on ob1.person_id=p.person_id
					inner join
					concept_name cn 
                        on cn.concept_id=ob1.concept_id
                        and cn.concept_name_type='FULLY_SPECIFIED'
                        and cn.locale='en'
                        and ob1.voided=0 and (cn.name='User_type_pop' or cn.name='User_type')
                group by ob1.person_id
                having max(obs_id)=(SELECT max(ob.obs_id) as iobs_id
                    from
                    obs ob 
                    inner join person on person.person_id=ob.person_id
                    INNER join concept_name cn on cn.concept_id=ob.value_coded
                       where cn.concept_name_type='FULLY_SPECIFIED'
                       and ob.voided=0
                       and cn.locale='en'
                       and (cn.name='APSS_user_pop' OR cn.name='APSS_an_Clinical_user_pop' OR cn.name='APSS_user' OR cn.name='APSS_an_Clinical_user')
                       and ob.person_id=ob1.person_id)) result on result.personid=p.person_id
                ) person ON person_id = patient_id
        AND encounter_type != 2
        AND DATE(encounter.encounter_datetime) BETWEEN '#startDate#' and '#endDate#') obs

         LEFT JOIN (SELECT
                    value_text,
                    value_numeric,
                    concept_name_type,
                    name,
                    locale,
                    encounter_id,
                    obs_id
                    FROM
                    obs
                      JOIN concept_name c ON c.concept_id = obs.concept_id
                    WHERE
                    concept_name_type = 'FULLY_SPECIFIED'
                    AND locale = 'en'
                    AND name = 'BP_Diastolic_VSNormal') AS diastolic ON diastolic.encounter_id = obs.encounter_id
         LEFT JOIN (SELECT
                    value_text,
                    value_numeric,
                    concept_name_type,
                    name,
                    locale,
                    encounter_id,
                    obs_id
                    FROM
                    obs
                      JOIN concept_name c ON c.concept_id = obs.concept_id
                    WHERE
                    concept_name_type = 'FULLY_SPECIFIED'
                    AND locale = 'en'
                    AND name = 'Blood_Pressure_–_Systolic_VS1') AS sistolic ON sistolic.encounter_id = obs.encounter_id
         LEFT JOIN (SELECT
					MAX(start_date_time) AS next_consultation,
                    p.person_id,
                    pa.status
                    FROM
                    patient_appointment pa
                      JOIN person p ON p.person_id = pa.patient_id
                      AND pa.voided IS FALSE
					JOIN appointment_service aps on aps.appointment_service_id = pa.appointment_service_id
                    AND aps.name like "%Clinica%"
 group by person_id
ORDER BY start_date_time DESC) AS appointment ON appointment.person_id = obs.person_id
LEFT JOIN (SELECT
        preg.obs_id,
            preg.encounter_id,
            CASE
                WHEN cn_pregnancy.name = 'Pregnancy_Yes' THEN 'G'
                WHEN cn_pregnancy.name = 'Pregnancy_No' THEN ''
            END AS pregnant
    FROM
        (SELECT
        value_text,
            value_numeric,
            value_coded,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'Pregnancy_Yes_No') preg
    JOIN (SELECT
        name, concept_id
    FROM
        concept_name
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en') cn_pregnancy ON cn_pregnancy.concept_id = preg.value_coded) pregnancy_state ON pregnancy_state.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        breast_feeding.obs_id,
            breast_feeding.encounter_id,
            CASE
                WHEN cn_breast_feeding.name = 'True' THEN 'L'
                WHEN cn_breast_feeding.name = 'False' THEN ''
            END AS breast_feeding_value
    FROM
        (SELECT
        value_text,
            value_numeric,
            value_coded,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'Breastfeeding_ANA') breast_feeding
    JOIN (SELECT
        name, concept_id
    FROM
        concept_name
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en') cn_breast_feeding ON cn_breast_feeding.concept_id = breast_feeding.value_coded) brestfeeding_state ON brestfeeding_state.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        value_datetime,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'Last Menstruation Date') AS date_of_menstruation ON date_of_menstruation.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        condom.obs_id,
            condom.encounter_id,
            CASE
                WHEN cn_condom.name = 'Family_Planning_Contraceptive_Methods_PRES_Condom_button_Yes' THEN 'SIM'
                WHEN cn_condom.name = 'Family_Planning_Contraceptive_Methods_PRES_Condom_button_No' THEN 'NÃO'
            END AS condom_value
    FROM
        (SELECT
        value_text,
            value_numeric,
            value_coded,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'Family_Planning_Contraceptive_Methods_PRES_Condom_button') condom
    JOIN (SELECT
        name, concept_id
    FROM
        concept_name
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en') cn_condom ON cn_condom.concept_id = condom.value_coded) condom_usage ON condom_usage.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        cn_who_staging.name, who_staging.encounter_id
    FROM
        (SELECT
        value_text,
            value_numeric,
            value_coded,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'HTC, WHO Staging') who_staging
    JOIN (SELECT
        name, concept_id
    FROM
        concept_name
    WHERE
        concept_name_type = 'SHORT'
            AND locale = 'pt') cn_who_staging ON cn_who_staging.concept_id = who_staging.value_coded) table_WHO_staging ON table_WHO_staging.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        value_text,
            value_numeric,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'WEIGHT') weight ON weight.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        value_text,
            value_numeric,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'HEIGHT') height ON height.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        value_text,
            value_numeric,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'BMI') bmi ON bmi.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        value_text,
            value_numeric,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'Brachial_perimeter_new') bperimeter ON bperimeter.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        nutritional_eval.obs_id,
            nutritional_eval.encounter_id,
            CASE
                WHEN cn_nutritional_eval.name = 'CO_SAM' THEN 'Desnutrição aguda grave'
                WHEN cn_nutritional_eval.name = 'CO_Normal' THEN 'Normal'
                WHEN cn_nutritional_eval.name = 'CO_MAM' THEN 'Desnutrição aguda moderada'
                WHEN cn_nutritional_eval.name = 'CO_LAM' THEN 'Desnutrição aguda ligeira'
                WHEN cn_nutritional_eval.name = 'CO_Overweight' THEN 'Sobrepeso'
                WHEN cn_nutritional_eval.name = 'CO_OneDO' THEN 'Obesidade grau 1'
                WHEN cn_nutritional_eval.name = 'CO_TwoDO' THEN 'Obesidade grau 2'
                WHEN cn_nutritional_eval.name = 'CO_ThreeDO' THEN 'Obesidade grau 3'
                WHEN cn_nutritional_eval.name = 'CO_Obese' THEN 'Obesidade'
            END AS nutritional_eval
    FROM
        (SELECT
        value_text,
            value_numeric,
            value_coded,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'Nutritional_States_new') nutritional_eval
    JOIN (SELECT
        name, concept_id
    FROM
        concept_name
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en') cn_nutritional_eval ON cn_nutritional_eval.concept_id = nutritional_eval.value_coded) imc_eval ON imc_eval.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        odemas.obs_id,
            odemas.encounter_id,
            CASE
                WHEN cn_odemas.name = 'Infants Odema_O' THEN 'O'
                WHEN cn_odemas.name = 'Infants Odema_+' THEN '+'
                WHEN cn_odemas.name = 'Infants Odema_++' THEN '++'
                WHEN cn_odemas.name = 'Infants Odema_+++' THEN '+++'
            END AS odemas_value
    FROM
        (SELECT
        value_text,
            value_numeric,
            value_coded,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'Infants Odema_Prophylaxis') odemas
    JOIN (SELECT
        name, concept_id
    FROM
        concept_name
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en') cn_odemas ON cn_odemas.concept_id = odemas.value_coded) odema ON odema.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        nutritional_education.obs_id,
            nutritional_education.encounter_id,
            CASE
                WHEN cn_nutritional_education.name = 'True' THEN 'SIM'
                WHEN cn_nutritional_education.name = 'False' THEN 'NÃO'
            END AS received
    FROM
        (SELECT
        value_text,
            value_numeric,
            value_coded,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'Received nutritional education') nutritional_education
    JOIN (SELECT
        name, concept_id
    FROM
        concept_name
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en') cn_nutritional_education ON cn_nutritional_education.concept_id = nutritional_education.value_coded) nutritional_education ON nutritional_education.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        nutrition_supplement.obs_id,
            nutrition_supplement.encounter_id,
            CASE
                WHEN cn_nutrition_supplement.name = 'Soya__Prophylaxis' THEN 'Soja'
                WHEN cn_nutrition_supplement.name = 'ATPUS__Prophylaxis' THEN 'ATPU'
                WHEN cn_nutrition_supplement.name = 'Other__Prophylaxis' THEN 'Outro'
            END AS supplement
    FROM
        (SELECT
        value_text,
            value_numeric,
            value_coded,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'Nutrition Supplement') nutrition_supplement
    JOIN (SELECT
        name, concept_id
    FROM
        concept_name
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en') cn_nutrition_supplement ON cn_nutrition_supplement.concept_id = nutrition_supplement.value_coded) nutritional_supplement ON nutritional_supplement.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        value_text,
            value_numeric,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'Quantity of Nutritional Supplement') AS suppl_quant ON suppl_quant.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        symptoms.obs_id,
            symptoms.encounter_id,
            CASE
                WHEN cn_symptoms.name = 'True' THEN 'SIM'
                WHEN cn_symptoms.name = 'False' THEN 'NÃO'
            END AS symptoms_value
    FROM
        (SELECT
        value_text,
            value_numeric,
            value_coded,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'Has TB Symptoms') symptoms
    JOIN (SELECT
        name, concept_id
    FROM
        concept_name
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en') cn_symptoms ON cn_symptoms.concept_id = symptoms.value_coded) has_symptoms ON has_symptoms.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        encounter_id, GROUP_CONCAT(supplement) AS symptoms
    FROM
        (SELECT
        symptomslist.obs_id,
            symptomslist.encounter_id,
            CASE
                WHEN cn_symptomslist.name = 'Fever_PL' THEN 'Febre'
                WHEN cn_symptomslist.name = 'Recent weight loss' THEN 'Emagrecimento Recente'
                WHEN cn_symptomslist.name = 'Cough with blood_Prophylaxis' THEN 'Tosse com Sangue'
                WHEN cn_symptomslist.name = 'Cough without blood_Prophylaxis' THEN 'Tosse sem Sangue'
                WHEN cn_symptomslist.name = 'Asthenia' THEN 'Astenia'
                WHEN cn_symptomslist.name = 'Recent contact with Tuberculosis' THEN 'Contacto Recente com TB'
            END AS supplement
    FROM
        (SELECT
        value_text,
            value_numeric,
            value_coded,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'Symptoms Prophylaxis_New') symptomslist
    JOIN (SELECT
        name, concept_id
    FROM
        concept_name
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en') cn_symptomslist ON cn_symptomslist.concept_id = symptomslist.value_coded) list_of_symptoms
    GROUP BY encounter_id) symptoms_list ON symptoms_list.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        CASE
                WHEN value_datetime IS NULL THEN 'NÃO'
                WHEN value_datetime IS NOT NULL THEN 'SIM'
            END AS v_datetime,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'Date of Diagnosis') AS date_of_diagnosis ON date_of_diagnosis.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        value_datetime,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'SP_Treatment Start Date') AS date_of_TB_start ON date_of_TB_start.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        value_datetime,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'SP_Treatment End Date') AS date_of_TB_end ON date_of_TB_end.encounter_id = obs.encounter_id
LEFT JOIN (SELECT * FROM (SELECT
        value_datetime,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'Start_Date_Prophylaxis_INH' ORDER BY obs_id)t GROUP BY encounter_id) AS date_of_prophylaxis_start ON date_of_prophylaxis_start.encounter_id = obs.encounter_id
LEFT JOIN (SELECT * FROM (SELECT
        value_datetime,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'End_Date_Prophylaxis_INH' ORDER BY obs_id)t GROUP BY encounter_id) AS date_of_prophylaxis_end ON date_of_prophylaxis_end.encounter_id = obs.encounter_id
LEFT JOIN (SELECT * FROM (SELECT
        value_datetime,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'Start_Date_Prophylaxis_CTZ' ORDER BY obs_id DESC)t GROUP BY encounter_id) AS date_of_CTZ_prophylaxis_start ON date_of_CTZ_prophylaxis_start.encounter_id = obs.encounter_id
LEFT JOIN (SELECT * FROM (SELECT
        value_datetime,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'End_Date_Prophylaxis_CTZ' ORDER BY obs.obs_id DESC) t GROUP BY encounter_id ) AS date_of_CTZ_prophylaxis_end  ON date_of_CTZ_prophylaxis_end.encounter_id = obs.encounter_id
LEFT JOIN (SELECT * FROM (SELECT
        TB_state.obs_id,
            TB_state.encounter_id,
            CASE
                WHEN cn_TB_state.name = 'Start_SP' THEN 'Início'
                WHEN cn_TB_state.name = 'Em Curso' THEN 'Em curso'
                WHEN cn_TB_state.name = 'End' THEN 'Fim'
            END AS state
    FROM
        (SELECT
        value_text,
            value_numeric,
            value_coded,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'SP_Treatment State') TB_state
    JOIN (SELECT
        name, concept_id
    FROM
        concept_name
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en') cn_TB_state ON cn_TB_state.concept_id = TB_state.value_coded ORDER BY obs_id) t GROUP BY obs_id) state_of_TB ON state_of_TB.encounter_id = obs.encounter_id
LEFT JOIN (SELECT * FROM (SELECT
        prophylaxis_state.obs_id,
            prophylaxis_state.encounter_id,
            CASE
                WHEN cn_prophylaxis_state.name = 'Inicio_Prophylaxis' THEN 'Início'
                WHEN cn_prophylaxis_state.name = 'Em Curso_Prophylaxis' THEN 'Em curso'
                WHEN cn_prophylaxis_state.name = 'Fim_Prophylaxis' THEN 'Fim'
            END AS state
    FROM
        (SELECT
        value_text,
            value_numeric,
            value_coded,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'State_prophylaxis_INH') prophylaxis_state
    JOIN (SELECT
        name, concept_id
    FROM
        concept_name
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en') cn_prophylaxis_state ON cn_prophylaxis_state.concept_id = prophylaxis_state.value_coded ORDER BY obs_id DESC) t GROUP BY encounter_id) state_of_prophylaxis ON state_of_prophylaxis.encounter_id = obs.encounter_id

LEFT JOIN (SELECT * FROM(
    SELECT
        prophylaxis_state.obs_id,
            prophylaxis_state.encounter_id,
            CASE
                WHEN cn_prophylaxis_state.name = 'Inicio_Prophylaxis' THEN 'Início'
                WHEN cn_prophylaxis_state.name = 'Em Curso_Prophylaxis' THEN 'Em curso'
                WHEN cn_prophylaxis_state.name = 'Fim_Prophylaxis' THEN 'Fim'
            END AS state
    FROM
        (SELECT
        value_text,
            value_numeric,
            value_coded,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'State_prophylaxis_CTZ') prophylaxis_state
    JOIN (SELECT
        name, concept_id
    FROM
        concept_name
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en') cn_prophylaxis_state ON cn_prophylaxis_state.concept_id = prophylaxis_state.value_coded ORDER BY obs_id DESC) t GROUP BY encounter_id) state_of_prophylaxis_CTZ ON state_of_prophylaxis_CTZ.encounter_id = obs.encounter_id

LEFT JOIN (SELECT
        secondary_efects.obs_id,
            secondary_efects.encounter_id,
            CASE
                WHEN cn_secondary_efects.name = 'True' THEN 'SIM'
                WHEN cn_secondary_efects.name = 'False' THEN 'NÃO'
            END AS has_sec_efects
    FROM
        (SELECT
        value_text,
            value_numeric,
            value_coded,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'SP_Side_Effects_INH') secondary_efects
    JOIN (SELECT
        name, concept_id
    FROM
        concept_name
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en') cn_secondary_efects ON cn_secondary_efects.concept_id = secondary_efects.value_coded) sec_efects ON sec_efects.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        secondary_efects_ctz.obs_id,
            secondary_efects_ctz.encounter_id,
            CASE
                WHEN cn_secondary_efects_ctz.name = 'True' THEN 'SIM'
                WHEN cn_secondary_efects_ctz.name = 'False' THEN 'NÃO'
            END AS has_sec_efects_ctz
    FROM
        (SELECT
        value_text,
            value_numeric,
            value_coded,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'SP_Side_Effects_CTZ') secondary_efects_ctz
    JOIN (SELECT
        name, concept_id
    FROM
        concept_name
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en') cn_secondary_efects_ctz ON cn_secondary_efects_ctz.concept_id = secondary_efects_ctz.value_coded) sec_efects_ctz ON sec_efects_ctz.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        its_symptoms.obs_id,
            its_symptoms.encounter_id,
            CASE
                WHEN cn_its_symptoms.name = 'True' THEN 'SIM'
                WHEN cn_its_symptoms.name = 'False' THEN 'NÃO'
            END AS has_its_symptoms
    FROM
        (SELECT
        value_text,
            value_numeric,
            value_coded,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'Has STI Symptoms') its_symptoms
    JOIN (SELECT
        name, concept_id
    FROM
        concept_name
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en') cn_its_symptoms ON cn_its_symptoms.concept_id = its_symptoms.value_coded) symptoms_of_its ON symptoms_of_its.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        syndromic_appr_male.obs_id,
            syndromic_appr_male.encounter_id,
            CASE
                WHEN cn_syndromic_appr_male.name = 'CUM_Urethral discharge' THEN 'CUM-Corrimento uretral'
                WHEN cn_syndromic_appr_male.name = 'UG-Úlcera Genital ulcer' THEN 'UG-Úlcera genital'
                WHEN cn_syndromic_appr_male.name = 'ESI-Swollen Scrotum' THEN 'ESI-Escroto Inchado'
                WHEN cn_syndromic_appr_male.name = 'BI-Inguinal Bubo' THEN 'BI-Inguinal Bubo'
            END AS approach
    FROM
        (SELECT
        value_text,
            value_numeric,
            value_coded,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'Syndromic Approach_STI_M') syndromic_appr_male
    JOIN (SELECT
        name, concept_id
    FROM
        concept_name
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en') cn_syndromic_appr_male ON cn_syndromic_appr_male.concept_id = syndromic_appr_male.value_coded) male_syndromic_appr ON male_syndromic_appr.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        syndromic_appr_female.obs_id,
            syndromic_appr_female.encounter_id,
            CASE
                WHEN cn_syndromic_appr_female.name = 'CV-Vaginal discharge' THEN 'CV-Corrimento Vaginal'
                WHEN cn_syndromic_appr_female.name = 'DIP-Pain in the belly (5791)' THEN 'ATPU'
                WHEN cn_syndromic_appr_female.name = 'UG-Úlcera Genital ulcer' THEN 'UG-Úlcera genital'
                WHEN cn_syndromic_appr_female.name = 'BI-Inguinal Bubo' THEN 'BI-Inguinal Bubo'
            END AS approach
    FROM
        (SELECT
        value_text,
            value_numeric,
            value_coded,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'Syndromic Approach_STI_F') syndromic_appr_female
    JOIN (SELECT
        name, concept_id
    FROM
        concept_name
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en') cn_syndromic_appr_female ON cn_syndromic_appr_female.concept_id = syndromic_appr_female.value_coded) female_syndromic_appr ON female_syndromic_appr.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        encounter_id, GROUP_CONCAT(name) AS infections
    FROM
        (SELECT
        secondary_efects.obs_id,
            secondary_efects.encounter_id,
            cn_secondary_efects.name
    FROM
        (SELECT
        value_text,
            value_numeric,
            value_coded,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'Coded Diagnosis') secondary_efects
    JOIN (SELECT
        name, concept_id
    FROM
        concept_name
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en') cn_secondary_efects ON cn_secondary_efects.concept_id = secondary_efects.value_coded) opp_infections
    GROUP BY encounter_id) op_infections ON op_infections.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        value_numeric,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'LO_ViralLoad'
            AND obs.value_numeric <> 0) AS viral_load ON viral_load.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        patient_id, encounter_id, GROUP_CONCAT(DISTINCT LD) AS LD
    FROM
        (SELECT
        drug,
            patient_id,
            encounter_id,
            order_id,
            GROUP_CONCAT(DISTINCT LD) AS LD
    FROM
        (SELECT
        CONCAT(COALESCE(d.line_of_treatment,''), '-', COALESCE(d.dosing_instructions,'')) AS LD,
            d.order_id,
            d.encounter_id,
            d.patient_id,
            d.drug
    FROM
        (SELECT
        drug.order_id,
            drug.concept_id,
            drug.encounter_id,
            drug.patient_id,
            drug.dose_units,
            CASE
				WHEN drug.dosing_instructions = '{"instructions":"Month"}' THEN 'Mensal'
                WHEN drug.dosing_instructions = '{"instructions":"Trimester"}' THEN 'Trimestral'
                WHEN drug.dosing_instructions = '{"instructions":"Semiannual"}' THEN 'Semestral'
                WHEN drug.dosing_instructions = '{"instructions":"Mensal"}' THEN 'Mensal'
                WHEN drug.dosing_instructions = '{"instructions":"Trimestral"}' THEN 'Trimestral'
                WHEN drug.dosing_instructions = '{"instructions":"Semestral"}' THEN 'Semestral'
            END AS dosing_instructions,
            drug.quantity,
            drug.drug,
            concept_name.name AS line_of_treatment
    FROM
        (SELECT
        ord.order_id,
            ord.concept_id,
            ord.encounter_id,
            ord.patient_id,
            dose_units,
            dosing_instructions,
            quantity,
            dor.category_id,
            dor.treatment_line_id,
            cn.name AS drug
    FROM
        orders ord
    JOIN drug_order dorder ON ord.order_id = dorder.order_id
    AND  ISNULL(ord.date_stopped)
    AND  ISNULL(ord.previous_order_id)
    INNER JOIN drug_order_relationship dor ON dor.drug_order_id = ord.order_id
       AND dor.category_id IN ((select concept_id as drug_concept_id from concept_name where locale = 'en' and  concept_name_type = 'FULLY_SPECIFIED' AND name = 'Antirretrovirals'),(select concept_id as drug_concept_id from concept_name where locale = 'en' and  concept_name_type = 'FULLY_SPECIFIED' AND name = 'Other Category'))
    JOIN concept_name cn ON cn.concept_id = ord.concept_id
        AND cn.locale = 'en'
        AND cn.concept_name_type = 'FULLY_SPECIFIED') drug
    JOIN concept_name ON concept_name.concept_id = drug.treatment_line_id
        AND concept_name.locale = 'pt'
        AND concept_name.concept_name_type = 'FULLY_SPECIFIED') d) p_table
    GROUP BY order_id) p1_table
    GROUP BY encounter_id) line_dispense ON line_dispense.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        order_id,
            encounter_id,
            dose_units,
            GROUP_CONCAT(distinct drugs) AS drugs
    FROM
        (SELECT
        order_id,
            encounter_id,
            dose_units,
            GROUP_CONCAT(distinct drug) AS drugs
    FROM
        (SELECT
        drug.order_id,
            drug.concept_id,
            drug.encounter_id,
            drug.patient_id,
            drug.dose_units,
            drug.quantity,
            drug.drug,
            concept_name.name AS line_of_treatment
    FROM
        (SELECT
        ord.order_id,
            ord.concept_id,
            ord.encounter_id,
            ord.patient_id,
            dose_units,
            dosing_instructions,
            quantity,
            dor.category_id,
            dor.treatment_line_id,
            cn.name AS drug
    FROM
        orders ord
    JOIN drug_order dorder ON ord.order_id = dorder.order_id
    AND  ISNULL(ord.date_stopped)
    AND  ISNULL(ord.previous_order_id)
    INNER JOIN drug_order_relationship dor ON dor.drug_order_id = ord.order_id
       AND dor.category_id IN ((select concept_id as drug_concept_id from concept_name where locale = 'en' and  concept_name_type = 'FULLY_SPECIFIED' AND name = 'Antirretrovirals'),(select concept_id as drug_concept_id from concept_name where locale = 'en' and  concept_name_type = 'FULLY_SPECIFIED' AND name = 'Other Category'))
    JOIN concept_name cn ON cn.concept_id = ord.concept_id
        AND cn.locale = 'en'
        AND cn.concept_name_type = 'FULLY_SPECIFIED') drug
    JOIN concept_name ON concept_name.concept_id = drug.treatment_line_id
        AND concept_name.locale = 'en'
        AND concept_name.concept_name_type = 'FULLY_SPECIFIED') drug_table
    GROUP BY order_id) drugs_table
    GROUP BY drugs_table.encounter_id) drugs_regime ON drugs_regime.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        order_id,
            encounter_id,
            patient_id,
            GROUP_CONCAT(DISTINCT freq) AS freq
    FROM
        (SELECT
        order_id,
            encounter_id,
            patient_id,
            GROUP_CONCAT(DISTINCT freq) AS freq
    FROM
        (SELECT
        ord.order_id,
            ord.encounter_id,
            ord.patient_id,
            frequency,
            dose_units,
            dosing_instructions,
            quantity,
            dor.category_id,
            dor.treatment_line_id,
            CONCAT(dose,'-',cn.name) AS freq
    FROM
        orders ord
    JOIN drug_order dorder ON ord.order_id = dorder.order_id
    AND  ISNULL(ord.date_stopped)
    AND  ISNULL(ord.previous_order_id)
    INNER JOIN drug_order_relationship dor ON dor.drug_order_id = ord.order_id
       AND dor.category_id IN ((select concept_id as drug_concept_id from concept_name where locale = 'en' and  concept_name_type = 'FULLY_SPECIFIED' AND name = 'Antirretrovirals'),(select concept_id as drug_concept_id from concept_name where locale = 'en' and  concept_name_type = 'FULLY_SPECIFIED' AND name = 'Other Category'))
    JOIN order_frequency of ON of.order_frequency_id = dorder.frequency
    JOIN concept_name cn ON cn.concept_id = of.concept_id
        AND cn.locale = 'pt'
        AND cn.concept_name_type = 'FULLY_SPECIFIED') freq
    GROUP BY order_id) frequency
    GROUP BY encounter_id) frqncy ON frqncy.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        *
    FROM
        patient_status_state
    WHERE
        date(patient_status_state.date_created) <= date('#endDate#')
        ORDER BY patient_status_state.id) patient_state ON patient_state.patient_id = obs.patient_id AND date(patient_state.date_created) <=date(encounter_datetime)
LEFT JOIN (
    SELECT
        list_services.encounter_id,
        list_services.services AS services,
        list_services.obs_group_id
    FROM
        (SELECT
            encounter_id,
            MAX(obs_group_id) AS obs_group_id,
            GROUP_CONCAT(other_services) AS services
        FROM
            (SELECT
                serviceslist.obs_id,
                serviceslist.encounter_id,
                serviceslist.obs_group_id,
                CASE
                    WHEN cn_serviceslist.name = 'Reference_TB' THEN 'TB'
                    WHEN cn_serviceslist.name = 'Reference_PTV' THEN 'PTV'
                    WHEN cn_serviceslist.name = 'Reference_PF' THEN 'PF'
                    WHEN cn_serviceslist.name = 'Reference_APSS&PP' THEN 'APSS&PP'
                    WHEN cn_serviceslist.name = 'Reference_In patient' THEN 'Internamento'
                    WHEN cn_serviceslist.name = 'Reference_Other' THEN 'Outro'
                END AS other_services
            FROM
                (SELECT
                    value_text,
                    value_numeric,
                    value_coded,
                    concept_name_type,
                    name,
                    locale,
                    encounter_id,
                    obs_group_id,
                    obs_id
                FROM
                    obs
                JOIN concept_name c ON c.concept_id = obs.concept_id
                WHERE
                    concept_name_type = 'FULLY_SPECIFIED'
                    AND locale = 'en'
                    AND name = 'Reference_Other_Services'
                    ) serviceslist
            JOIN (
                    SELECT
                        name,
                        concept_id
                    FROM
                        concept_name
                    WHERE
                        concept_name_type = 'FULLY_SPECIFIED'
                        AND locale = 'en'
                    ) cn_serviceslist ON cn_serviceslist.concept_id = serviceslist.value_coded
                ) list_of_services
        GROUP BY encounter_id) AS list_services
    INNER JOIN (
        SELECT
            ob_service_user.encounter_id,
            ob_service_user.concept_id,
            ob_service_user.obs_group_id
        FROM
            obs ob_service_user
        WHERE
            ob_service_user.concept_id = (SELECT concept_id FROM concept_name WHERE concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND name = 'User_type')
            AND ob_service_user.value_coded IN (SELECT concept_id FROM concept_name WHERE concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND (name = 'Clinical_user' OR name = 'APSS_an_Clinical_user' OR name = 'Clinical_user_pop' OR name = 'APSS_an_Clinical_user_pop'))
            AND ob_service_user.voided = 0
    ) AS service_form_fields
        ON service_form_fields.obs_group_id = list_services.obs_group_id
) services_list
    ON services_list.encounter_id = obs.encounter_id
LEFT JOIN (
    SELECT
        grupo_de_apoio.encounter_id,
        grupo_de_apoio.g_apoio_list,
        grupo_de_apoio.obs_group_id
    FROM
        (SELECT
            g_apoio.encounter_id,
            GROUP_CONCAT(g_apoio.sg_list_with_states) AS g_apoio_list,
            MAX(g_apoio.obs_group_id) AS obs_group_id
        FROM
            (SELECT
                sg_obs.obs_id,
                sg_obs.encounter_id,
                sg_obs.obs_group_id,
                CONCAT_WS(' - ', sg_shortname.name, sg_status.name) AS sg_list_with_states
            FROM
                (SELECT
                    sg_obs_in.obs_id,
                    sg_obs_in.obs_group_id,
                    sg_obs_in.encounter_id,
                    sg_obs_in.concept_id,
                    sg_obs_in.person_id,
                    sg_obs_in.value_coded
                FROM
                    obs AS sg_obs_in) AS sg_obs
            JOIN (SELECT
                    c_name_pt.concept_id, c_name_pt.name
                FROM
                    concept_name AS c_name_pt
                WHERE
                    c_name_pt.concept_id IN (SELECT
                            concept_id
                        FROM
                            concept_name
                        WHERE
                            name IN ('Reference_CR' , 'Reference_PC', 'Reference_AR', 'Reference_MPS')
                                AND concept_name_type = 'FULLY_SPECIFIED'
                                AND locale = 'en'
                            ORDER BY concept_id ASC)
                    AND c_name_pt.concept_name_type = 'SHORT'
                    AND c_name_pt.locale = 'pt') sg_shortname ON sg_obs.concept_id = sg_shortname.concept_id
    JOIN (SELECT
        c_name_status.concept_id, c_name_status.name
    FROM
        concept_name AS c_name_status
    WHERE
        c_name_status.concept_id IN (SELECT
                concept_id
            FROM
                concept_name
            WHERE
                name IN ('Reference_Start' , 'Reference_In_Progress', 'Reference_End')
                    AND concept_name_type = 'FULLY_SPECIFIED'
                    AND locale = 'en')
            AND c_name_status.concept_name_type = 'SHORT'
            AND c_name_status.locale = 'pt') sg_status ON sg_status.concept_id = sg_obs.value_coded) g_apoio
    GROUP BY encounter_id) AS grupo_de_apoio
    INNER JOIN (
        SELECT
            ob_g_apoio_form.encounter_id,
            ob_g_apoio_form.obs_group_id
        FROM
            encounter e_g_apoio_form, obs ob_g_apoio_form, concept_name cn_g_apoio_form
        WHERE
            e_g_apoio_form.encounter_id = ob_g_apoio_form.encounter_id
            AND cn_g_apoio_form.concept_id = ob_g_apoio_form.concept_id
            AND cn_g_apoio_form.concept_name_type = 'FULLY_SPECIFIED'
            AND cn_g_apoio_form.locale = 'en'
            AND cn_g_apoio_form.name = 'Reference_Section_Support_Group'
    ) AS g_apoio_form
        ON g_apoio_form.encounter_id = grupo_de_apoio.obs_group_id
    INNER JOIN (
        SELECT
            ob_g_apoio_user.encounter_id,
            ob_g_apoio_user.concept_id,
            ob_g_apoio_user.obs_group_id
        FROM
            obs ob_g_apoio_user
        WHERE
            ob_g_apoio_user.concept_id = (SELECT concept_id FROM concept_name WHERE concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND name = 'User_type')
            AND ob_g_apoio_user.value_coded IN (SELECT concept_id FROM concept_name WHERE concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND (name = 'Clinical_user' OR name = 'APSS_an_Clinical_user' OR name = 'Clinical_user_pop' OR name = 'APSS_an_Clinical_user_pop'))
            AND ob_g_apoio_user.voided = 0
    ) AS g_apoio_form_fields
        ON g_apoio_form_fields.obs_group_id = g_apoio_form.obs_group_id
) gr_apoio ON gr_apoio.encounter_id = obs.encounter_id
LEFT JOIN (
    SELECT
        mdc_table_data.encounter_id,
        mdc_table_data.obs_group_id,
        mdc_table_data.states AS states
    FROM
        (SELECT
                GROUP_CONCAT(mdc_table.mdc_list_with_states) AS states,
                    mdc_table.encounter_id,
                    mdc_table.obs_id,
                    mdc_table.obs_group_id
            FROM
                (SELECT
                CONCAT_WS(' - ', mdc_shortname.name, mdc_status.name) AS mdc_list_with_states,
                    mdc_obs.obs_id,
                    mdc_obs.encounter_id,
                    mdc_obs.obs_group_id
            FROM
                (SELECT
                obs_mdc.obs_id,
                    obs_mdc.concept_id,
                    obs_mdc.person_id,
                    obs_mdc.value_coded,
                    obs_mdc.encounter_id,
                    obs_mdc.obs_group_id
            FROM
                obs AS obs_mdc) mdc_obs
            JOIN (SELECT
                c_name_pt.concept_id, c_name_pt.name
            FROM
                concept_name AS c_name_pt
            WHERE
                c_name_pt.concept_id IN (SELECT
                        concept_id
                    FROM
                        concept_name
                    WHERE
                        name IN ('Reference_GA' , 'Reference_AF', 'Reference_CA', 'Reference_PU', 'Reference_FR', 'Reference_DT', 'Reference_DC', 'Reference_MDC_Other')
                            AND concept_name_type = 'FULLY_SPECIFIED'
                            AND locale = 'en'
                    ORDER BY concept_id ASC)
                    AND c_name_pt.concept_name_type = 'SHORT'
                    AND c_name_pt.locale = 'pt') mdc_shortname ON mdc_obs.concept_id = mdc_shortname.concept_id
            JOIN (SELECT
                c_name_status.concept_id, c_name_status.name
            FROM
                concept_name AS c_name_status
            WHERE
                c_name_status.concept_id IN (SELECT
                        concept_id
                    FROM
                        concept_name
                    WHERE
                        name IN ('Reference_Start' , 'Reference_In_Progress', 'Reference_End')
                            AND concept_name_type = 'FULLY_SPECIFIED'
                            AND locale = 'en')
                    AND c_name_status.concept_name_type = 'SHORT'
                    AND c_name_status.locale = 'pt') mdc_status ON mdc_status.concept_id = mdc_obs.value_coded) mdc_table
            GROUP BY encounter_id) AS mdc_table_data
    INNER JOIN (
        SELECT
            ob_g_apoio_form.encounter_id,
            ob_g_apoio_form.obs_group_id
        FROM
            encounter e_g_apoio_form, obs ob_g_apoio_form, concept_name cn_g_apoio_form
        WHERE
            e_g_apoio_form.encounter_id = ob_g_apoio_form.encounter_id
            AND cn_g_apoio_form.concept_id = ob_g_apoio_form.concept_id
            AND cn_g_apoio_form.concept_name_type = 'FULLY_SPECIFIED'
            AND cn_g_apoio_form.locale = 'en'
            AND cn_g_apoio_form.name = 'Reference_Section_Support_Group'
    ) AS g_apoio_form
        ON g_apoio_form.obs_group_id = mdc_table_data.obs_group_id
    INNER JOIN (
        SELECT
            ob_g_apoio_user.encounter_id,
            ob_g_apoio_user.concept_id,
            ob_g_apoio_user.obs_group_id
        FROM
            obs ob_g_apoio_user
        WHERE
            ob_g_apoio_user.concept_id = (SELECT concept_id FROM concept_name WHERE concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND name = 'User_type')
            AND ob_g_apoio_user.value_coded IN (SELECT concept_id FROM concept_name WHERE concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND (name = 'Clinical_user' OR name = 'APSS_an_Clinical_user' OR name = 'Clinical_user_pop' OR name = 'APSS_an_Clinical_user_pop'))
            AND ob_g_apoio_user.voided = 0
    ) AS g_apoio_form_fields
        ON g_apoio_form_fields.obs_group_id = g_apoio_form.obs_group_id    
) table_mdc
    ON table_mdc.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        GROUP_CONCAT(name) AS list_sg, encounter_id
    FROM
        (SELECT
        sg_obs.obs_id,
            sg_shortname.name,
            sg_obs.encounter_id,
            sg_obs.concept_id,
            sg_obs.person_id,
            sg_obs.value_coded
    FROM
        obs AS sg_obs
    JOIN (SELECT
        c_name_pt.concept_id, c_name_pt.name
    FROM
        concept_name AS c_name_pt
    WHERE
        c_name_pt.concept_id IN (SELECT
                concept_id
            FROM
                concept_name
            WHERE
                name IN ('Reference_CR' , 'Reference_PC', 'Reference_AR', 'Reference_MPS')
                    AND concept_name_type = 'FULLY_SPECIFIED'
                    AND locale = 'en'
            ORDER BY concept_id ASC)
            AND c_name_pt.concept_name_type = 'SHORT'
            AND c_name_pt.locale = 'pt') sg_shortname ON sg_obs.concept_id = sg_shortname.concept_id) support_group
    GROUP BY encounter_id   ) sg_list2 ON sg_list2.encounter_id = obs.encounter_id
LEFT JOIN (
    SELECT 
        sg_list_names.list_sg AS list_sg,
        sg_list_names.encounter_id
    FROM
        (SELECT
        GROUP_CONCAT(name) AS list_sg, encounter_id
        FROM
        (SELECT
            sg_obs.obs_id,
            sg_shortname.name,
            sg_obs.encounter_id,
            sg_obs.concept_id,
            sg_obs.person_id,
            sg_obs.value_coded
        FROM
            obs AS sg_obs
        JOIN (SELECT
            c_name_pt.concept_id, c_name_pt.name
        FROM
            concept_name AS c_name_pt
        WHERE
            c_name_pt.concept_id IN (SELECT
                    concept_id
                FROM
                    concept_name
                WHERE
                    name IN ('Reference_CR' , 'Reference_PC', 'Reference_AR', 'Reference_MPS')
                        AND concept_name_type = 'FULLY_SPECIFIED'
                        AND locale = 'en'
                ORDER BY concept_id ASC)
                AND c_name_pt.concept_name_type = 'SHORT'
                AND c_name_pt.locale = 'pt') sg_shortname ON sg_obs.concept_id = sg_shortname.concept_id) support_group
        GROUP BY encounter_id   ) AS sg_list_names
    INNER JOIN (
        SELECT
            ob_g_apoio_form.encounter_id,
            ob_g_apoio_form.obs_group_id
        FROM
            encounter e_g_apoio_form, obs ob_g_apoio_form, concept_name cn_g_apoio_form
        WHERE
            e_g_apoio_form.encounter_id = ob_g_apoio_form.encounter_id
            AND cn_g_apoio_form.concept_id = ob_g_apoio_form.concept_id
            AND cn_g_apoio_form.concept_name_type = 'FULLY_SPECIFIED'
            AND cn_g_apoio_form.locale = 'en'
            AND cn_g_apoio_form.name = 'Reference_Section_Support_Group'
    ) AS g_apoio_form
        ON g_apoio_form.encounter_id = sg_list_names.encounter_id
    INNER JOIN (
        SELECT
            ob_g_apoio_user.encounter_id,
            ob_g_apoio_user.concept_id,
            ob_g_apoio_user.obs_group_id
        FROM
            obs ob_g_apoio_user
        WHERE
            ob_g_apoio_user.concept_id = (SELECT concept_id FROM concept_name WHERE concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND name = 'User_type')
            AND ob_g_apoio_user.value_coded IN (SELECT concept_id FROM concept_name WHERE concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND (name = 'Clinical_user' OR name = 'APSS_an_Clinical_user' OR name = 'Clinical_user_pop' OR name = 'APSS_an_Clinical_user_pop'))
            AND ob_g_apoio_user.voided = 0
    ) AS g_apoio_form_fields
        ON g_apoio_form_fields.obs_group_id = g_apoio_form.obs_group_id

) sg_list ON sg_list.encounter_id = obs.encounter_id
LEFT JOIN ( 
    SELECT
        mdc_eligibility_data.encounter_id,
        mdc_eligibility_data.obs_group_id,
        mdc_eligibility_data.mdc_yes_no
    FROM
        (SELECT
                mdc_obs.encounter_id,
                MAX(mdc_obs.obs_group_id) AS obs_group_id,
                    CASE
                        WHEN mdc_obs.value_coded = 1 THEN 'Sim'
                        WHEN mdc_obs.value_coded = 2 THEN 'Não'
                    END AS mdc_yes_no
            FROM
                (SELECT
                    obs_mdc.obs_id,
                    obs_mdc.obs_group_id,
                    obs_mdc.encounter_id,
                    obs_mdc.concept_id,
                    obs_mdc.person_id,
                    obs_mdc.value_coded
            FROM
                obs AS obs_mdc
            WHERE
                obs_mdc.concept_id IN (SELECT
                        mdc_concept.concept_id
                    FROM
                        concept_name AS mdc_concept
                    WHERE
                        name IN ('Reference_Eligible')
                            AND mdc_concept.concept_name_type = 'FULLY_SPECIFIED'
                            AND mdc_concept.locale = 'en'
                    ORDER BY mdc_concept.concept_id ASC)) AS mdc_obs) AS mdc_eligibility_data
        INNER JOIN (
            SELECT
                ob_g_apoio_user.encounter_id,
                ob_g_apoio_user.concept_id,
                ob_g_apoio_user.obs_group_id
            FROM
                obs ob_g_apoio_user
            WHERE
                ob_g_apoio_user.concept_id = (SELECT concept_id FROM concept_name WHERE concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND name = 'User_type')
                AND ob_g_apoio_user.value_coded IN (SELECT concept_id FROM concept_name WHERE concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND (name = 'Clinical_user' OR name = 'APSS_an_Clinical_user' OR name = 'Clinical_user_pop' OR name = 'APSS_an_Clinical_user_pop'))
                AND ob_g_apoio_user.voided = 0
        ) g_apoio_form_fields ON g_apoio_form_fields.obs_group_id = mdc_eligibility_data.obs_group_id
) mdc_eligibility
    ON mdc_eligibility.encounter_id = obs.encounter_id
LEFT JOIN (
    SELECT
        mdc_data.encounter_id,
        mdc_data.obs_group_id,
        mdc_data.modelos_diferenciados AS modelos_diferenciados
    FROM 
        (SELECT
            mdc_obs.encounter_id,
            MAX(mdc_obs.obs_group_id) as obs_group_id,
            GROUP_CONCAT(name
                SEPARATOR ', ') AS modelos_diferenciados
        FROM
        ((SELECT
        obs_mdc.obs_id,
        obs_mdc.obs_group_id,
        obs_mdc.encounter_id,
        obs_mdc.concept_id,
        obs_mdc.person_id,
        obs_mdc.value_coded
        FROM
        obs AS obs_mdc) mdc_obs
        JOIN (SELECT
                c_name_pt.concept_id, c_name_pt.name
                FROM
                concept_name AS c_name_pt
                WHERE
                c_name_pt.concept_id IN (SELECT
                                        concept_id
                                        FROM
                                        concept_name
                                        WHERE
                                        name IN ('Reference_GA' , 'Reference_AF', 'Reference_CA', 'Reference_PU', 'Reference_FR', 'Reference_DT', 'Reference_DC', 'Reference_MDC_Other')
                                        AND concept_name_type = 'FULLY_SPECIFIED'
                                        AND locale = 'en'
                                        ORDER BY concept_id ASC)
                AND c_name_pt.concept_name_type = 'SHORT'
                AND c_name_pt.locale = 'pt') mdc_shortname ON mdc_obs.concept_id = mdc_shortname.concept_id)
        GROUP BY encounter_id) AS mdc_data
    INNER JOIN (
        SELECT
            ob_g_apoio_form.encounter_id,
            ob_g_apoio_form.obs_group_id
        FROM
            encounter e_g_apoio_form, obs ob_g_apoio_form, concept_name cn_g_apoio_form
        WHERE
            e_g_apoio_form.encounter_id = ob_g_apoio_form.encounter_id
            AND cn_g_apoio_form.concept_id = ob_g_apoio_form.concept_id
            AND cn_g_apoio_form.concept_name_type = 'FULLY_SPECIFIED'
            AND cn_g_apoio_form.locale = 'en'
            AND cn_g_apoio_form.name = 'Reference_MDC_Section'
    ) AS g_apoio_form
        ON g_apoio_form.obs_group_id = mdc_data.obs_group_id
    INNER JOIN (
        SELECT
            ob_g_apoio_user.encounter_id,
            ob_g_apoio_user.concept_id,
            ob_g_apoio_user.obs_group_id
        FROM
            obs ob_g_apoio_user
        WHERE
            ob_g_apoio_user.concept_id = (SELECT concept_id FROM concept_name WHERE concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND name = 'User_type')
            AND ob_g_apoio_user.value_coded IN (SELECT concept_id FROM concept_name WHERE concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND (name = 'Clinical_user' OR name = 'APSS_an_Clinical_user' OR name = 'Clinical_user_pop' OR name = 'APSS_an_Clinical_user_pop'))
            AND ob_g_apoio_user.voided = 0
    ) AS g_apoio_form_fields
        ON g_apoio_form_fields.obs_group_id = g_apoio_form.obs_group_id
) mdc_table1 ON mdc_table1.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        GROUP_CONCAT(name) AS family_planning, encounter_id
    FROM
        (SELECT
        sg_obs.obs_id,
            sg_shortname.name,
            sg_obs.encounter_id,
            sg_obs.concept_id,
            sg_obs.person_id,
            sg_obs.value_coded
    FROM
        obs AS sg_obs
    JOIN (SELECT
        c_name_pt.concept_id, c_name_pt.name
    FROM
        concept_name AS c_name_pt
    WHERE
        c_name_pt.concept_id IN (SELECT
                concept_id
            FROM
                concept_name
            WHERE
                name IN ('Family_Planning_Contraceptive_Methods_PIL_Oral_Contraceptive_button' , 'Family_Planning_Contraceptive_Methods_INJ_Injection_button', 'Family_Planning_Contraceptive_Methods_IMP_Implant_button', 'Family_Planning_Contraceptive_Methods_DIU_Intra_button')
                    AND concept_name_type = 'FULLY_SPECIFIED'
                    AND locale = 'en'
            ORDER BY concept_id ASC)
            AND c_name_pt.concept_name_type = 'SHORT'
            AND c_name_pt.locale = 'pt') sg_shortname ON sg_obs.concept_id = sg_shortname.concept_id) f_planning
    GROUP BY encounter_id) fplanning ON fplanning.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        f_planning_condom.obs_id,
            f_planning_condom.encounter_id,
            CASE
                WHEN cn_f_planning_condom.name = 'Family_Planning_Contraceptive_Methods_PRES_Condom_button_Yes' THEN 'Preservativo,'
                WHEN cn_f_planning_condom.name = 'Family_Planning_Contraceptive_Methods_PRES_Condom_button_No' THEN ''
            END AS fp_condom
    FROM
        (SELECT
        value_text,
            value_numeric,
            value_coded,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'Family_Planning_Contraceptive_Methods_PRES_Condom_button') f_planning_condom
    JOIN (SELECT
        name, concept_id
    FROM
        concept_name
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en') cn_f_planning_condom ON cn_f_planning_condom.concept_id = f_planning_condom.value_coded) fpcond ON fpcond.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        f_planning_laq_trompas.obs_id,
            f_planning_laq_trompas.encounter_id,
            CASE
                WHEN cn_f_planning_laq_trompas.name = 'Family_Planning_Contraceptive_Methods_LT_Tubal_Ligation_button_Yes' THEN ',Laqueação das Trompas'
                WHEN cn_f_planning_laq_trompas.name = 'Family_Planning_Contraceptive_Methods_LT_Tubal_Ligation_button_No' THEN ''
            END AS tubal_ligation
    FROM
        (SELECT
        value_text,
            value_numeric,
            value_coded,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'Family_Planning_Contraceptive_Methods_LT_Tubal_Ligation_button') f_planning_laq_trompas
    JOIN (SELECT
        name, concept_id
    FROM
        concept_name
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en') cn_f_planning_laq_trompas ON cn_f_planning_laq_trompas.concept_id = f_planning_laq_trompas.value_coded) fp_tubal_ligation ON fp_tubal_ligation.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        f_planning_laq_amenoreia_method.obs_id,
            f_planning_laq_amenoreia_method.encounter_id,
            CASE
                WHEN cn_f_planning_laq_amenoreia_method.name = 'Family_Planning_Contraceptive_Methods_MAL_Lactational_Amenorrhea_Method_button_Yes' THEN ',Método Amenorreia Lactacional'
                WHEN cn_f_planning_laq_amenoreia_method.name = 'Family_Planning_Contraceptive_Methods_MAL_Lactational_Amenorrhea_Method_button_No' THEN ''
            END AS amenorreia_method
    FROM
        (SELECT
        value_text,
            value_numeric,
            value_coded,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'Family_Planning_Contraceptive_Methods_MAL_Lactational_Amenorrhea_Method_button') f_planning_laq_amenoreia_method
    JOIN (SELECT
        name, concept_id
    FROM
        concept_name
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en') cn_f_planning_laq_amenoreia_method ON cn_f_planning_laq_amenoreia_method.concept_id = f_planning_laq_amenoreia_method.value_coded) fp_amenorreia ON fp_amenorreia.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        f_planning_other.obs_id,
            f_planning_other.encounter_id,
            CASE
                WHEN cn_f_planning_other.name = 'Family_Planning_Contraceptive_Methods_OUT_Other_button_Yes' THEN ',Outro'
                WHEN cn_f_planning_other.name = 'Family_Planning_Contraceptive_Methods_OUT_Other_button_No' THEN ''
            END AS fp_other_method
    FROM
        (SELECT
        value_text,
            value_numeric,
            value_coded,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name = 'Family_Planning_Contraceptive_Methods_OUT_Other_button') f_planning_other
    JOIN (SELECT
        name, concept_id
    FROM
        concept_name
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en') cn_f_planning_other ON cn_f_planning_other.concept_id = f_planning_other.value_coded) fp_other ON fp_other.encounter_id = obs.encounter_id
LEFT JOIN (
    SELECT
        kp.encounter_id,
        kp.person_id,
        kp.obs_group_id,
        kp_fields.concept_id,
        kp_fields.value_coded,
        kp.pop_chave
    FROM
        (SELECT
            e.encounter_id,
            ob.person_id,
            ob.value_coded,
            ob.obs_group_id,
            ob.concept_id,
            (SELECT
                    name
                FROM
                    concept_name
                WHERE
                    concept_id = ob.value_coded
                    AND locale = 'pt'
                    AND concept_name_type = 'SHORT') AS pop_chave
        FROM
            obs ob, encounter e, concept_name cn
        WHERE
            e.encounter_id = ob.encounter_id
            AND e.patient_id = ob.person_id
            AND ob.concept_id = cn.concept_id
            AND cn.concept_name_type = 'FULLY_SPECIFIED'
            AND cn.locale = 'en'
            AND cn.name = 'PP_If_Key_population_yes') AS kp
    INNER JOIN (
        SELECT 
            ob_kp.encounter_id,
            ob_kp.person_id,
            ob_kp.value_coded,
            ob_kp.concept_id,
            ob_kp.obs_group_id,
            ob_kp.obs_id
        FROM
            obs ob_kp
        WHERE
            ob_kp.concept_id = (SELECT concept_id FROM concept_name WHERE concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND name = 'User_type_pop')
            AND ob_kp.value_coded IN (SELECT concept_id FROM concept_name WHERE concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND (name = 'Clinical_user' OR name = 'APSS_an_Clinical_user' OR name = 'Clinical_user_pop' OR name = 'APSS_an_Clinical_user_pop'))
            AND ob_kp.voided = 0
    ) kp_fields 
        ON kp_fields.obs_group_id = kp.obs_group_id
) key_population ON key_population.encounter_id = obs.encounter_id
LEFT JOIN (
    SELECT
        populucao_vulneravel.encounter_id,
        populucao_vulneravel.pop_vul AS pop_vul,
        populucao_vulneravel.obs_group_id,
        vp_fields.concept_id,
        vp_fields.value_coded
    FROM
        (SELECT
            e.encounter_id,
            ob.person_id,
            ob.value_coded,
            ob.obs_group_id,
            (SELECT
                name
            FROM
                concept_name
            WHERE
                concept_id = ob.value_coded
                AND locale = 'pt'
                AND concept_name_type = 'SHORT') AS pop_vul
    FROM
        obs ob, encounter e, concept_name cn
    WHERE
        ob.person_id = e.patient_id
        AND ob.encounter_id = e.encounter_id
        AND ob.concept_id = cn.concept_id
        AND cn.concept_name_type = 'FULLY_SPECIFIED'
        AND cn.locale = 'en'
        AND cn.name = 'PP_IF_Vulnerable_Population_Yes') AS populucao_vulneravel
    INNER JOIN (
        SELECT 
            ob_kp.encounter_id,
            ob_kp.person_id,
            ob_kp.value_coded,
            ob_kp.concept_id,
            ob_kp.obs_group_id,
            ob_kp.obs_id
        FROM
            obs ob_kp
        WHERE
            ob_kp.concept_id = (SELECT concept_id FROM concept_name WHERE concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND name = 'User_type_pop')
            AND ob_kp.value_coded IN (SELECT concept_id FROM concept_name WHERE concept_name_type = 'FULLY_SPECIFIED' AND locale = 'en' AND (name = 'Clinical_user' OR name = 'APSS_an_Clinical_user' OR name = 'Clinical_user_pop' OR name = 'APSS_an_Clinical_user_pop'))
            AND ob_kp.voided = 0
    ) vp_fields 
        ON vp_fields.obs_group_id = populucao_vulneravel.obs_group_id
) vp ON vp.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        concept_name_type,
            GROUP_CONCAT(name) AS lab_tests,
            locale,
            encounter_id,
            orders.concept_id
    FROM
        orders
    JOIN concept_name c ON c.concept_id = orders.concept_id
    WHERE
        concept_name_type = 'SHORT'
            AND locale = 'pt'
    GROUP BY encounter_id) lab_requests ON lab_requests.encounter_id = obs.encounter_id
LEFT JOIN (SELECT
        GROUP_CONCAT(CONCAT(co_name.name, '-', value_numeric)) AS res,
            encounter_id
    FROM
        (SELECT
        value_numeric,
            concept_name_type,
            name,
            locale,
            encounter_id,
            obs_id,
            obs.concept_id
    FROM
        obs
    JOIN concept_name c ON c.concept_id = obs.concept_id
    WHERE
        concept_name_type = 'FULLY_SPECIFIED'
            AND locale = 'en'
            AND name IN ('CD4 %', 'CD4 Abs', 'CARGA VIRAL (Absoluto-Rotina)', 'CARGA VIRAL (Absoluto-Suspeita)', 'CARGA VIRAL(Qualitativo-Suspeita)', 'CARGA VIRAL(Qualitativo-Rotina)', 'LO_ViralLoad' , 'LO_CD4', 'LO_HB', 'LO_AST', 'LO_ALT', 'LO_ViralLoad', 'LO_GLYCEMIA(3.05-6.05mmol/L)', 'LO_AMILASE(600-1600/UL)', 'LO_CREATININE(4.2-132Hmol/L)', 'LO_Other')
            AND obs.value_numeric <> 0) res_table
    JOIN concept_name co_name ON co_name.concept_id = res_table.concept_id
        AND co_name.concept_name_type = 'SHORT'
        AND co_name.locale = 'pt'
    GROUP BY encounter_id) gr_results ON gr_results.encounter_id = obs.encounter_id
LEFT JOIN (
    SELECT e.encounter_id,e.patient_id,e.creator,(SELECT CONCAT(given_name,' ',family_name)
 FROM person_name
WHERE person_id = (SELECT person_id FROM users WHERE user_id = e.creator)) AS provider
FROM  encounter e
    ) prov ON prov.encounter_id = obs.encounter_id

ORDER BY encounter_datetime DESC)temp_table GROUP BY encounter_datetime, patient_id) global_table
