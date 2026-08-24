<?xml version="1.0" encoding="UTF-8"?>
<!--
    Rules in this file are grouped into two categories:
    Structural Rules — validate how measurement data is identified, organized, and aligned.
    GP_EPCS_RULE_004 — Measurement-result column alignment: Numeric columns in the same result table shall contain equal numbers of data items.
    GP_EPCS_RULE_006 — Measurement-result column identification: Every column in a tabular measurement result shall have a non-empty, human-readable name.

    Logical Rules — validate semantic, chronological, interval, and calculation relationships between values.
    GP_EPCS_RULE_001 — Calibration performance date order: The calibration start date shall not be later than the end date.
    GP_EPCS_RULE_002 — Calibrated weighing range order: The lower endpoint shall not exceed the upper endpoint after unit conversion.
    GP_EPCS_RULE_003 — Equipment certificate validity: A recorded validity date shall cover the calibration end date.
    GP_EPCS_RULE_005 — Repeatability range calculation: The reported repeatability shall equal the maximum observed error minus the minimum observed error.

    Rules in this file are grouped into two categories:
    Structural Rules — validate how measurement data is identified, organized, and aligned.
    GP_EPCS_RULE_004 — Measurement-result column alignment: Numeric columns in the same result table shall contain equal numbers of data items.
    GP_EPCS_RULE_006 — Measurement-result column identification: Every column in a tabular measurement result shall have a non-empty, human-readable name.

    Logical Rules — validate semantic, chronological, interval, and calculation relationships between values.
    GP_EPCS_RULE_001 — Calibration performance date order: The calibration start date shall not be later than the end date.
    GP_EPCS_RULE_002 — Calibrated weighing range order: The lower endpoint shall not exceed the upper endpoint after unit conversion.
    GP_EPCS_RULE_003 — Equipment certificate validity: A recorded validity date shall cover the calibration end date.
    GP_EPCS_RULE_005 — Repeatability range calculation: The reported repeatability shall equal the maximum observed error minus the minimum observed error.
-->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns:dcc="https://ptb.de/dcc"
    xmlns:si="https://ptb.de/si"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    queryBinding="xslt2">
    <sch:title>GP_EPCS General Business Rules for Digital Calibration Certificates</sch:title>

    <sch:ns prefix="dcc" uri="https://ptb.de/dcc"/>
    <sch:ns prefix="si" uri="https://ptb.de/si"/>
    <sch:ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>

    <!--
        Scope: This file verifies the internal consistency of calibration-certificate data and calculations.
        Structural rules validate data identification, organization, and alignment. Logical rules validate chronological order,
        interval integrity, traceability-record validity, and reproducible calculations. Neither category prescribes
        accuracy classes, maximum permissible errors, verification periods, seals, or conformity decisions.

        Scope: This file verifies the internal consistency of calibration-certificate data and calculations.
        Structural rules validate data identification, organization, and alignment. Logical rules validate chronological order,
        interval integrity, traceability-record validity, and reproducible calculations. Neither category prescribes
        accuracy classes, maximum permissible errors, verification periods, seals, or conformity decisions.
    -->

    <!--
        Logical Rule GP_EPCS_RULE_001 — Calibration performance date order.
        Principle: A measurement activity represented by a start date and an end date shall have a coherent
        chronology; the start shall precede or equal the end. This is a general record-integrity requirement.
        Scope: Date syntax and required fields are handled by the DCC XSD. This rule compares the dates only
        when both values are valid dates and does not make a conformity decision about the calibrated instrument.

        Logical Rule GP_EPCS_RULE_001 — Calibration performance date order.
        Principle: A measurement activity represented by a start date and an end date shall have a coherent
        chronology; the start shall precede or equal the end. This is a general record-integrity requirement.
        Scope: Date syntax and required fields are handled by the DCC XSD. This rule compares the dates only
        when both values are valid dates and does not make a conformity decision about the calibrated instrument.
    -->
    <sch:pattern id="performance-date-order">
        <sch:title>Calibration Performance Date Order</sch:title>
        <sch:rule context="dcc:digitalCalibrationCertificate/dcc:administrativeData/dcc:coreData">
            <sch:assert id="GP_EPCS_RULE_001"
                role="error"
                diagnostics="GP_EPCS_RULE_001_DIAGNOSTIC"
                test="if (dcc:beginPerformanceDate castable as xs:date
                         and dcc:endPerformanceDate castable as xs:date)
                      then xs:date(dcc:beginPerformanceDate)
                           le xs:date(dcc:endPerformanceDate)
                      else true()">
                The calibration start date must not be later than the calibration end date.
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <!--
        Logical Rule GP_EPCS_RULE_002 — Calibrated weighing range order.
        Principle: A measurement interval is defined by a lower and an upper endpoint, and the lower endpoint
        shall not exceed the upper endpoint. Values are converted to kilograms before comparison so that
        equivalent quantities expressed in grams and kilograms can be compared consistently.
        Scope: This rule checks interval integrity only; it does not impose an accuracy class, scale interval,
        capacity limit, permissible error, or conformity decision.

        Logical Rule GP_EPCS_RULE_002 — Calibrated weighing range order.
        Principle: A measurement interval is defined by a lower and an upper endpoint, and the lower endpoint
        shall not exceed the upper endpoint. Values are converted to kilograms before comparison so that
        equivalent quantities expressed in grams and kilograms can be compared consistently.
        Scope: This rule checks interval integrity only; it does not impose an accuracy class, scale interval,
        capacity limit, permissible error, or conformity decision.
    -->
    <sch:pattern id="calibrated-range-order">
        <sch:title>Calibrated Weighing Range Endpoint Order</sch:title>
        <sch:rule context="dcc:digitalCalibrationCertificate/dcc:administrativeData/dcc:items/dcc:item[contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_electronicPriceComputingScale ')]/dcc:subItems/dcc:item[contains(concat(' ', normalize-space(@refType), ' '), ' NAWI_range1 ')]">
            <sch:let name="lower"
                value="dcc:itemQuantities/dcc:itemQuantity[contains(concat(' ', normalize-space(@refType), ' '), ' math_minimum ')]/si:real"/>
            <sch:let name="upper"
                value="dcc:itemQuantities/dcc:itemQuantity[contains(concat(' ', normalize-space(@refType), ' '), ' math_maximum ')]/si:real"/>
            <sch:let name="lower-kg"
                value="if (count($lower) = 1)
                       then if ($lower/si:value castable as xs:decimal)
                            then if (normalize-space(string($lower/si:unit)) = '\kilogram')
                                 then xs:decimal($lower/si:value)
                                 else if (normalize-space(string($lower/si:unit)) = '\gram')
                                      then xs:decimal($lower/si:value) div 1000
                                      else ()
                            else ()
                       else ()"/>
            <sch:let name="upper-kg"
                value="if (count($upper) = 1)
                       then if ($upper/si:value castable as xs:decimal)
                            then if (normalize-space(string($upper/si:unit)) = '\kilogram')
                                 then xs:decimal($upper/si:value)
                                 else if (normalize-space(string($upper/si:unit)) = '\gram')
                                      then xs:decimal($upper/si:value) div 1000
                                      else ()
                            else ()
                       else ()"/>
            <sch:assert id="GP_EPCS_RULE_002"
                role="error"
                diagnostics="GP_EPCS_RULE_002_DIAGNOSTIC"
                test="count($lower) = 1
                      and count($upper) = 1
                      and exists($lower-kg)
                      and exists($upper-kg)
                      and $lower-kg le $upper-kg">
                The calibrated weighing range must have exactly one comparable lower endpoint and one comparable upper endpoint, and the lower endpoint must not exceed the upper endpoint.
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <!--
        Logical Rule GP_EPCS_RULE_003 — Measurement-equipment certificate validity.
        Principle: Traceability records used to support a measurement should be temporally consistent with the
        measurement activity. When an equipment or reference-standard certificate validity date is recorded,
        it shall cover the calibration end date.
        Scope: This rule applies only when the "valid until" field is present. It neither requires every device
        to use this field nor independently determines metrological traceability or instrument conformity.

        Logical Rule GP_EPCS_RULE_003 — Measurement-equipment certificate validity.
        Principle: Traceability records used to support a measurement should be temporally consistent with the
        measurement activity. When an equipment or reference-standard certificate validity date is recorded,
        it shall cover the calibration end date.
        Scope: This rule applies only when the "valid until" field is present. It neither requires every device
        to use this field nor independently determines metrological traceability or instrument conformity.
    -->
    <sch:pattern id="equipment-certificate-validity">
        <sch:title>Consistency Between Measurement-Equipment Certificate Validity and Calibration Date</sch:title>
        <sch:rule context="dcc:digitalCalibrationCertificate/dcc:measurementResults/dcc:measuringEquipments/dcc:measuringEquipment[contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_standardWeightSet ')][dcc:description[contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_standardValidityEndDate ')]]">
            <sch:let name="valid-until"
                value="normalize-space(string(dcc:description[contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_standardValidityEndDate ')]/dcc:content))"/>
            <sch:let name="valid-until-date"
                value="substring($valid-until, 1, 10)"/>
            <sch:let name="calibration-end"
                value="normalize-space(string(/dcc:digitalCalibrationCertificate/dcc:administrativeData/dcc:coreData/dcc:endPerformanceDate))"/>
            <sch:assert id="GP_EPCS_RULE_003"
                role="error"
                diagnostics="GP_EPCS_RULE_003_DIAGNOSTIC"
                test="if ($calibration-end castable as xs:date)
                      then if ($valid-until-date castable as xs:date)
                           then xs:date($valid-until-date) ge xs:date($calibration-end)
                           else false()
                      else true()">
                The recorded certificate validity date of the measurement equipment or reference standard must not be earlier than the calibration end date.
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <!--
        Structural Rule GP_EPCS_RULE_004 — Measurement-result column alignment.
        Principle: In a tabular measurement record, values on the same row describe the same observation.
        Numeric columns represented by si:valueXMLList shall therefore have equal lengths so that row-wise
        relationships remain unambiguous. A table with zero or one numeric list has no cross-column mismatch.
        Scope: This structural check applies generally to result tables and does not evaluate measurement limits,
        uncertainty, or conformity.

        Structural Rule GP_EPCS_RULE_004 — Measurement-result column alignment.
        Principle: In a tabular measurement record, values on the same row describe the same observation.
        Numeric columns represented by si:valueXMLList shall therefore have equal lengths so that row-wise
        relationships remain unambiguous. A table with zero or one numeric list has no cross-column mismatch.
        Scope: This structural check applies generally to result tables and does not evaluate measurement limits,
        uncertainty, or conformity.
    -->
    <sch:pattern id="result-list-column-lengths">
        <sch:title>Numeric Column Alignment in Measurement Result Tables</sch:title>
        <sch:rule context="dcc:digitalCalibrationCertificate/dcc:measurementResults/dcc:measurementResult/dcc:results/dcc:result/dcc:data/dcc:list">
            <sch:let name="column-lengths"
                value="for $column in .//si:valueXMLList
                       return count(tokenize(normalize-space(string($column)), '\s+'))"/>
            <sch:assert id="GP_EPCS_RULE_004"
                role="error"
                diagnostics="GP_EPCS_RULE_004_DIAGNOSTIC"
                test="count($column-lengths) le 1
                      or (every $length in subsequence($column-lengths, 2)
                          satisfies $length = $column-lengths[1])">
                All numeric lists within the same measurement result table must contain the same number of data items.
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <!--
        Logical Rule GP_EPCS_RULE_005 — Repeatability range calculation.
        Principle: When repeatability is reported as the range of observed errors, it equals the maximum error
        minus the minimum error. The rule recalculates this value from at least two observations and converts
        supported mass units to kilograms before comparison, making the reported summary reproducible.
        Scope: This calculation check does not prescribe the number of trials, test loads, permissible errors,
        or a conformity decision.

        Logical Rule GP_EPCS_RULE_005 — Repeatability range calculation.
        Principle: When repeatability is reported as the range of observed errors, it equals the maximum error
        minus the minimum error. The rule recalculates this value from at least two observations and converts
        supported mass units to kilograms before comparison, making the reported summary reproducible.
        Scope: This calculation check does not prescribe the number of trials, test loads, permissible errors,
        or a conformity decision.
    -->
    <sch:pattern id="repeatability-range-calculation">
        <sch:title>Repeatability Range Calculation Consistency</sch:title>
        <sch:rule context="dcc:digitalCalibrationCertificate/dcc:measurementResults/dcc:measurementResult[contains(concat(' ', normalize-space(@refType), ' '), ' NAWI_repeatabilityMeasurement ')]">
            <sch:let name="error-list"
                value="dcc:results/dcc:result/dcc:data/dcc:list/dcc:quantity[contains(concat(' ', normalize-space(@refType), ' '), ' basic_measurementError ')]/si:realListXMLList"/>
            <sch:let name="error-tokens"
                value="tokenize(normalize-space(string($error-list/si:valueXMLList)), '\s+')"/>
            <sch:let name="error-unit"
                value="normalize-space(string($error-list/si:unitXMLList))"/>
            <sch:let name="errors-kg"
                value="for $error in $error-tokens
                       return if ($error castable as xs:decimal)
                              then if ($error-unit = '\kilogram')
                                   then xs:decimal($error)
                                   else if ($error-unit = '\gram')
                                        then xs:decimal($error) div 1000
                                        else ()
                              else ()"/>
            <sch:let name="reported-er"
                value="dcc:results/dcc:result/dcc:data/dcc:list/dcc:quantity[contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_repeatabilityValue ')]/si:real"/>
            <sch:let name="reported-er-kg"
                value="if (count($reported-er) = 1)
                       then if ($reported-er/si:value castable as xs:decimal)
                            then if (normalize-space(string($reported-er/si:unit)) = '\kilogram')
                                 then xs:decimal($reported-er/si:value)
                                 else if (normalize-space(string($reported-er/si:unit)) = '\gram')
                                      then xs:decimal($reported-er/si:value) div 1000
                                      else ()
                            else ()
                       else ()"/>
            <sch:assert id="GP_EPCS_RULE_005"
                role="error"
                diagnostics="GP_EPCS_RULE_005_DIAGNOSTIC"
                test="count($error-tokens) ge 2
                      and count($errors-kg) = count($error-tokens)
                      and count($reported-er) = 1
                      and exists($reported-er-kg)
                      and $reported-er-kg = max($errors-kg) - min($errors-kg)">
                Repeatability must equal the maximum observed error minus the minimum observed error.
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <!--
        Structural Rule GP_EPCS_RULE_006 — Measurement-result column identification.
        Principle: Column headings state what each recorded value represents. Every dcc:quantity used as a column
        in a tabular dcc:list shall therefore expose at least one non-empty, human-readable name, either directly
        as the quantity name or, for a non-numeric column, as the name within dcc:noQuantity.
        Scope: This rule checks column identification only. It does not require particular columns or evaluate
        units, values, measurement limits, uncertainty, or conformity.

        Structural Rule GP_EPCS_RULE_006 — Measurement-result column identification.
        Principle: Column headings state what each recorded value represents. Every dcc:quantity used as a column
        in a tabular dcc:list shall therefore expose at least one non-empty, human-readable name, either directly
        as the quantity name or, for a non-numeric column, as the name within dcc:noQuantity.
        Scope: This rule checks column identification only. It does not require particular columns or evaluate
        units, values, measurement limits, uncertainty, or conformity.
    -->
    <sch:pattern id="result-list-column-identification">
        <sch:title>Column Identification Completeness in Measurement Result Tables</sch:title>
        <sch:rule context="dcc:digitalCalibrationCertificate/dcc:measurementResults/dcc:measurementResult/dcc:results/dcc:result/dcc:data/dcc:list/dcc:quantity">
            <sch:assert id="GP_EPCS_RULE_006"
                role="error"
                diagnostics="GP_EPCS_RULE_006_DIAGNOSTIC"
                test="exists(dcc:name/dcc:content[normalize-space(.) != ''])
                      or exists(dcc:noQuantity/dcc:name/dcc:content[normalize-space(.) != ''])">
                Every column in the measurement result table must have a non-empty, human-readable name.
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:diagnostics>
        <sch:diagnostic id="GP_EPCS_RULE_001_DIAGNOSTIC">
            beginPerformanceDate=<sch:value-of select="dcc:beginPerformanceDate"/>;
            endPerformanceDate=<sch:value-of select="dcc:endPerformanceDate"/>.
        </sch:diagnostic>
        <sch:diagnostic id="GP_EPCS_RULE_002_DIAGNOSTIC">
            Lower endpoint=<sch:value-of select="dcc:itemQuantities/dcc:itemQuantity[contains(concat(' ', normalize-space(@refType), ' '), ' math_minimum ')]/si:real/si:value"/>
            <sch:value-of select="dcc:itemQuantities/dcc:itemQuantity[contains(concat(' ', normalize-space(@refType), ' '), ' math_minimum ')]/si:real/si:unit"/>;
            Upper endpoint=<sch:value-of select="dcc:itemQuantities/dcc:itemQuantity[contains(concat(' ', normalize-space(@refType), ' '), ' math_maximum ')]/si:real/si:value"/>
            <sch:value-of select="dcc:itemQuantities/dcc:itemQuantity[contains(concat(' ', normalize-space(@refType), ' '), ' math_maximum ')]/si:real/si:unit"/>.
        </sch:diagnostic>
        <sch:diagnostic id="GP_EPCS_RULE_003_DIAGNOSTIC">
            Equipment=<sch:value-of select="dcc:name/dcc:content[@lang = 'zh']"/>;
            Valid until=<sch:value-of select="dcc:description[contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_standardValidityEndDate ')]/dcc:content"/>;
            Calibration end date=<sch:value-of select="/dcc:digitalCalibrationCertificate/dcc:administrativeData/dcc:coreData/dcc:endPerformanceDate"/>.
        </sch:diagnostic>
        <sch:diagnostic id="GP_EPCS_RULE_004_DIAGNOSTIC">
            Result table=<sch:value-of select="ancestor::dcc:result[1]/dcc:name/dcc:content[1]"/>;
            Number of data items in each numeric column=<sch:value-of
                select="string-join(for $column in .//si:valueXMLList
                        return concat(normalize-space(string($column/ancestor::dcc:quantity[1]/dcc:name/dcc:content[1])),
                                      '=', count(tokenize(normalize-space(string($column)), '\s+'))),
                        ';')"/>.
        </sch:diagnostic>
        <sch:diagnostic id="GP_EPCS_RULE_005_DIAGNOSTIC">
            Error column=<sch:value-of select="dcc:results/dcc:result/dcc:data/dcc:list/dcc:quantity[contains(concat(' ', normalize-space(@refType), ' '), ' basic_measurementError ')]/si:realListXMLList/si:valueXMLList"/>;
            Recorded ER=<sch:value-of select="dcc:results/dcc:result/dcc:data/dcc:list/dcc:quantity[contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_repeatabilityValue ')]/si:real/si:value"/>.
        </sch:diagnostic>
        <sch:diagnostic id="GP_EPCS_RULE_006_DIAGNOSTIC">
            Result table=<sch:value-of select="ancestor::dcc:result[1]/dcc:name/dcc:content[1]"/>;
            Unnamed column index=<sch:value-of select="count(preceding-sibling::dcc:quantity) + 1"/>;
            refType=<sch:value-of select="@refType"/>.
        </sch:diagnostic>
    </sch:diagnostics>
</sch:schema>
