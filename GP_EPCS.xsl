<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:dcc="https://ptb.de/dcc"
    xmlns:si="https://ptb.de/si"
    exclude-result-prefixes="dcc si">

    <xsl:output method="html" version="5" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/dcc:digitalCalibrationCertificate">
        <xsl:variable name="admin" select="dcc:administrativeData"/>
        <xsl:variable name="core" select="$admin/dcc:coreData"/>
        <xsl:variable name="item" select="$admin/dcc:items/dcc:item[contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_electronicPriceComputingScale ')]"/>
        <xsl:variable name="measurements" select="dcc:measurementResults"/>
        <xsl:variable name="certificate-number"
            select="$core/dcc:identifications/dcc:identification[contains(concat(' ', normalize-space(@refType), ' '), ' basic_certificateNumber ')]/dcc:value"/>

        <html lang="zh-CN">
            <head>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <title>Electronic Price Computing Scale Calibration Certificate - <xsl:value-of select="$certificate-number"/></title>
                <style>
                    :root {
                        --ink: #11110f;
                        --muted: #57564f;
                        --paper: #fffef9;
                        --desk: #d8d6ce;
                        --inner: 0.12mm solid var(--ink);
                        --outer: 0.27mm solid var(--ink);
                    }

                    * { box-sizing: border-box; }

                    html, body { margin: 0; padding: 0; }

                    body {
                        color: var(--ink);
                        background:
                            radial-gradient(circle at 18% 12%, rgba(255,255,255,.65), transparent 28rem),
                            repeating-linear-gradient(90deg, rgba(34,33,29,.025) 0 1px, transparent 1px 5px),
                            var(--desk);
                        font-family: "FZShuSong-Z01S", "Noto Serif CJK SC", "Songti SC", SimSun, serif;
                        font-size: 9.1pt;
                        line-height: 1.35;
                        font-variant-numeric: tabular-nums lining-nums;
                        -webkit-font-smoothing: antialiased;
                    }

                    .sheet {
                        position: relative;
                        width: 210mm;
                        min-height: 297mm;
                        margin: 16px auto;
                        padding-top: 22mm;
                        padding-bottom: 12mm;
                        background:
                            linear-gradient(112deg, rgba(120,108,78,.018), transparent 38%),
                            var(--paper);
                        box-shadow: 0 18px 48px rgba(25, 24, 20, .2), 0 2px 8px rgba(25, 24, 20, .12);
                    }

                    .page-one { padding-left: 23.6mm; padding-right: 25.1mm; }
                    .page-two { padding-left: 25.1mm; padding-right: 23.6mm; }

                    .running-head {
                        display: grid;
                        grid-template-columns: 1fr auto 1fr;
                        align-items: baseline;
                        min-height: 8.8mm;
                        padding-bottom: 2.6mm;
                        border-bottom: var(--outer);
                        letter-spacing: .045em;
                    }

                    .running-code {
                        grid-column: 2;
                        font-family: "Times New Roman", "Noto Serif CJK SC", serif;
                        font-size: 9.7pt;
                        white-space: nowrap;
                    }

                    .running-code strong { font-weight: 700; letter-spacing: .08em; }

                    .schema-version {
                        grid-column: 3;
                        justify-self: end;
                        color: var(--muted);
                        font-family: "Times New Roman", serif;
                        font-size: 7pt;
                        letter-spacing: .08em;
                    }

                    .title-block {
                        margin: 8.2mm 0 7mm;
                        text-align: center;
                    }

                    h1 {
                        margin: 0;
                        font-family: "FZXiaoBiaoSong-B05S", STZhongsong, "Noto Serif CJK SC", SimSun, serif;
                        font-size: 17pt;
                        font-weight: 700;
                        letter-spacing: .13em;
                    }

                    .subtitle {
                        margin: 1.6mm 0 0;
                        color: var(--muted);
                        font-family: "Times New Roman", "Noto Serif CJK SC", serif;
                        font-size: 7.2pt;
                        letter-spacing: .08em;
                        text-transform: uppercase;
                    }

                    h2 {
                        margin: 3.1mm 0 1.4mm;
                        font-size: 9.8pt;
                        font-weight: 400;
                        letter-spacing: .035em;
                    }

                    table {
                        width: 100%;
                        border-collapse: collapse;
                        table-layout: fixed;
                    }

                    .meta-table, .equipment-table { border: var(--outer); }

                    .meta-table th, .meta-table td,
                    .equipment-table th, .equipment-table td {
                        border: var(--inner);
                        vertical-align: middle;
                    }

                    .meta-table th {
                        width: 18.3%;
                        height: 6.65mm;
                        padding: .55mm 1mm;
                        font-size: 8.45pt;
                        font-weight: 400;
                        text-align: center;
                        white-space: nowrap;
                    }

                    .meta-table td {
                        height: 6.65mm;
                        padding: .55mm 1.15mm;
                        font-family: "Times New Roman", "Noto Serif CJK SC", SimSun, serif;
                        font-size: 7.75pt;
                        text-align: center;
                        overflow-wrap: anywhere;
                    }

                    .meta-table .wide-value { text-align: left; padding-left: 1.8mm; }

                    .math {
                        font-family: "Times New Roman", serif;
                        font-style: italic;
                        letter-spacing: 0;
                    }

                    .equipment-table th {
                        height: 10.7mm;
                        padding: .8mm .7mm;
                        font-size: 8pt;
                        font-weight: 400;
                        text-align: center;
                    }

                    .equipment-table td {
                        min-height: 7.3mm;
                        padding: 1mm .8mm;
                        font-size: 7.25pt;
                        text-align: center;
                        overflow-wrap: anywhere;
                    }

                    .equipment-kind {
                        font-size: 8.2pt !important;
                        letter-spacing: .04em;
                    }

                    .equipment-quality .detail {
                        display: block;
                        margin-top: .45mm;
                        color: var(--muted);
                        font-size: 6.7pt;
                    }

                    .results-heading { margin-top: 3.2mm; }

                    .result-block { margin-top: 1.7mm; break-inside: avoid; }

                    .result-shell { border: var(--outer); }

                    .result-meta {
                        display: grid;
                        grid-template-columns: minmax(34mm, 1.35fr) minmax(61mm, 2fr) auto;
                        align-items: center;
                        min-height: 12mm;
                        padding: 1.2mm 2mm;
                        border-bottom: var(--inner);
                        column-gap: 2mm;
                    }

                    .result-title {
                        font-size: 9.1pt;
                        letter-spacing: .025em;
                    }

                    .result-ref {
                        display: block;
                        margin-top: .25mm;
                        color: var(--muted);
                        font-family: "Times New Roman", serif;
                        font-size: 6.3pt;
                        letter-spacing: .025em;
                    }

                    .tracking {
                        text-align: left;
                        font-size: 7.7pt;
                        white-space: nowrap;
                    }

                    .unit {
                        justify-self: end;
                        font-size: 7.7pt;
                        white-space: nowrap;
                    }

                    .check-option { margin-left: 1.6mm; white-space: nowrap; }

                    .box {
                        position: relative;
                        display: inline-block;
                        width: 2.7mm;
                        height: 2.7mm;
                        margin-left: .45mm;
                        border: var(--inner);
                        vertical-align: -.35mm;
                    }

                    .box.checked::after {
                        content: "";
                        position: absolute;
                        inset: .55mm;
                        background: var(--ink);
                    }

                    .tare-line {
                        grid-column: 1 / -1;
                        margin-top: .7mm;
                        color: var(--muted);
                        font-size: 7pt;
                    }

                    .result-table { border: 0; }

                    .result-table th, .result-table td {
                        border-right: var(--inner);
                        border-bottom: var(--inner);
                        text-align: center;
                        vertical-align: middle;
                    }

                    .result-table tr > *:last-child { border-right: 0; }
                    .result-table tbody tr:last-child > * { border-bottom: 0; }

                    .result-table th {
                        height: 10.6mm;
                        padding: .8mm .55mm;
                        font-size: 7.6pt;
                        font-weight: 400;
                        line-height: 1.24;
                    }

                    .result-table .subhead th {
                        height: 5.7mm;
                        padding: .35mm .25mm;
                        font-size: 6.7pt;
                    }

                    .result-table td {
                        height: 6.45mm;
                        padding: .45mm .38mm;
                        font-family: "Times New Roman", "Noto Serif CJK SC", SimSun, serif;
                        font-size: 6.9pt;
                        line-height: 1.15;
                        overflow-wrap: anywhere;
                    }

                    .result-table .symbol {
                        display: block;
                        margin-top: .65mm;
                        font-family: "Times New Roman", serif;
                        font-size: 8.2pt;
                        font-style: italic;
                    }

                    .result-table .row-index { font-size: 7.4pt; }

                    .marker {
                        margin-right: .35mm;
                        font-family: "Times New Roman", serif;
                        font-size: 7pt;
                        vertical-align: .45mm;
                    }

                    .result-note {
                        min-height: 6.2mm;
                        padding: 1mm 1.8mm;
                        border: var(--outer);
                        border-top: 0;
                        font-size: 7.25pt;
                    }

                    .result-note .formula {
                        margin-left: 1.5mm;
                        font-family: "Times New Roman", serif;
                        font-size: 8pt;
                        font-style: italic;
                    }

                    .page-two .result-block:first-of-type { margin-top: 4.2mm; }
                    .page-two .result-block { margin-top: 2.1mm; }
                    .page-two .result-meta { min-height: 11.1mm; }
                    .page-two .result-table td { height: 6.25mm; }
                    .page-two .result-table th { height: 9.7mm; }

                    .folio {
                        position: absolute;
                        bottom: 6.4mm;
                        font-family: "Times New Roman", serif;
                        font-size: 8.8pt;
                    }

                    .page-one .folio { left: 23.6mm; }
                    .page-two .folio { right: 23.6mm; }

                    @media screen and (max-width: 900px) {
                        body { overflow-x: auto; }
                        .sheet { margin: 0 auto 12px; box-shadow: none; }
                    }

                    @media print {
                        @page { size: A4 portrait; margin: 0; }

                        html, body { background: #fff; }

                        .sheet {
                            width: 210mm;
                            height: 297mm;
                            min-height: 297mm;
                            margin: 0;
                            box-shadow: none;
                            break-after: page;
                            page-break-after: always;
                        }

                        .sheet:last-child {
                            break-after: auto;
                            page-break-after: auto;
                        }
                    }
                </style>
            </head>
            <body>
                <article class="sheet page-one">
                    <xsl:call-template name="running-head"/>

                    <header class="title-block">
                        <h1>Electronic Price Computing Scale Calibration Certificate</h1>
                        <p class="subtitle">Electronic Price Computing Scale · Digital Calibration Certificate</p>
                    </header>

                    <table class="meta-table" aria-label="Basic Calibration Certificate Information">
                        <colgroup>
                            <col style="width:18.3%"/><col style="width:13.8%"/>
                            <col style="width:18.3%"/><col style="width:13.8%"/>
                            <col style="width:18.3%"/><col style="width:17.5%"/>
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>Customer</th>
                                <td><xsl:call-template name="localized-content"><xsl:with-param name="nodes" select="$admin/dcc:customer/dcc:name/dcc:content"/></xsl:call-template></td>
                                <th>Manufacturer</th>
                                <td><xsl:call-template name="localized-content"><xsl:with-param name="nodes" select="$item/dcc:manufacturer/dcc:name/dcc:content"/></xsl:call-template></td>
                                <th>Product Name</th>
                                <td><xsl:call-template name="localized-content"><xsl:with-param name="nodes" select="$item/dcc:name/dcc:content"/></xsl:call-template></td>
                            </tr>
                            <tr>
                                <th>Model / Specification</th>
                                <td><xsl:call-template name="value-or-dash"><xsl:with-param name="value" select="$item/dcc:model"/></xsl:call-template></td>
                                <th>Serial Number</th>
                                <td><xsl:call-template name="value-or-dash"><xsl:with-param name="value" select="$item/dcc:identifications/dcc:identification[contains(concat(' ', normalize-space(@refType), ' '), ' basic_serialNumber ')]/dcc:value"/></xsl:call-template></td>
                                <th>Accuracy Class</th>
                                <td><xsl:call-template name="value-or-dash"><xsl:with-param name="value" select="$item/dcc:equipmentClass[contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_accuracyClass ')]/dcc:classID"/></xsl:call-template></td>
                            </tr>
                            <tr>
                                <th>Verification Scale Interval <span class="math">e</span></th>
                                <td><xsl:call-template name="real-value"><xsl:with-param name="real" select="$item/dcc:subItems/dcc:item[contains(concat(' ', normalize-space(@refType), ' '), ' NAWI_range1 ')]/dcc:itemQuantities/dcc:itemQuantity[contains(concat(' ', normalize-space(@refType), ' '), ' NAWI_resolutionOfDisplayingDevice ')]/si:real"/></xsl:call-template></td>
                                <th>Maximum Capacity <span class="math">Max</span></th>
                                <td><xsl:call-template name="real-value"><xsl:with-param name="real" select="$item/dcc:subItems/dcc:item[contains(concat(' ', normalize-space(@refType), ' '), ' NAWI_range1 ')]/dcc:itemQuantities/dcc:itemQuantity[contains(concat(' ', normalize-space(@refType), ' '), ' math_maximum ')]/si:real"/></xsl:call-template></td>
                                <th>Minimum Capacity <span class="math">Min</span></th>
                                <td><xsl:call-template name="real-value"><xsl:with-param name="real" select="$item/dcc:subItems/dcc:item[contains(concat(' ', normalize-space(@refType), ' '), ' NAWI_range1 ')]/dcc:itemQuantities/dcc:itemQuantity[contains(concat(' ', normalize-space(@refType), ' '), ' math_minimum ')]/si:real"/></xsl:call-template></td>
                            </tr>
                            <tr>
                                <th>Seal Status</th>
                                <td colspan="3" class="wide-value"><xsl:call-template name="value-or-dash"><xsl:with-param name="value" select="$item/dcc:itemQuantities/dcc:itemQuantity[dcc:noQuantity/dcc:name/dcc:content='Seal Status'][1]/dcc:noQuantity/dcc:content[1]"/></xsl:call-template></td>
                                <th>Software Identification</th>
                                <td><xsl:call-template name="value-or-dash"><xsl:with-param name="value" select="$item/dcc:identifications/dcc:identification[dcc:name/dcc:content='Software Identification'][1]/dcc:value"/></xsl:call-template></td>
                            </tr>
                            <tr>
                                <th>Type Approval Number</th>
                                <td><xsl:call-template name="value-or-dash"><xsl:with-param name="value" select="$item/dcc:identifications/dcc:identification[dcc:name/dcc:content='Type Approval Number'][1]/dcc:value"/></xsl:call-template></td>
                                <th>Temperature / ℃</th>
                                <td><xsl:call-template name="value-or-dash"><xsl:with-param name="value" select="$measurements/dcc:influenceConditions/dcc:influenceCondition[contains(concat(' ', normalize-space(@refType), ' '), ' basic_temperature ')]/dcc:data/dcc:quantity/si:real/si:value"/></xsl:call-template></td>
                                <th>Relative Humidity / %</th>
                                <td><xsl:call-template name="value-or-dash"><xsl:with-param name="value" select="$measurements/dcc:influenceConditions/dcc:influenceCondition[contains(concat(' ', normalize-space(@refType), ' '), ' basic_humidityRelative ')]/dcc:data/dcc:quantity/si:real/si:value"/></xsl:call-template></td>
                            </tr>
                            <tr>
                                <th>Calibration Basis</th>
                                <td><xsl:call-template name="value-or-dash"><xsl:with-param name="value" select="$admin/dcc:statements/dcc:statement[contains(concat(' ', normalize-space(@refType), ' '), ' basic_calibrationMethod ')]/dcc:norm"/></xsl:call-template></td>
                                <th>Calibration Date</th>
                                <td>
                                    <xsl:value-of select="$core/dcc:beginPerformanceDate"/>
                                    <xsl:if test="string($core/dcc:endPerformanceDate) != string($core/dcc:beginPerformanceDate)">
                                        <xsl:text> to </xsl:text><xsl:value-of select="$core/dcc:endPerformanceDate"/>
                                    </xsl:if>
                                </td>
                                <th>Issue Date</th>
                                <td><xsl:call-template name="value-or-dash"><xsl:with-param name="value" select="$core/dcc:issueDate"/></xsl:call-template></td>
                            </tr>
                            <tr>
                                <th>Manufacturing Date</th>
                                <td><xsl:call-template name="value-or-dash"><xsl:with-param name="value" select="$item/dcc:itemQuantities/dcc:itemQuantity[contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_manufacturingDate ')]/dcc:noQuantity/dcc:content"/></xsl:call-template></td>
                                <th>Calibrator</th>
                                <td><xsl:call-template name="localized-content"><xsl:with-param name="nodes" select="$admin/dcc:respPersons/dcc:respPerson[contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_calibrator ')]/dcc:person/dcc:name/dcc:content"/></xsl:call-template></td>
                                <th>Reviewer</th>
                                <td><xsl:call-template name="localized-content"><xsl:with-param name="nodes" select="$admin/dcc:respPersons/dcc:respPerson[contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_reviewer ')]/dcc:person/dcc:name/dcc:content"/></xsl:call-template></td>
                            </tr>
                            <tr>
                                <th>Calibration Location</th>
                                <td colspan="3" class="wide-value"><xsl:call-template name="location"><xsl:with-param name="node" select="$admin/dcc:statements/dcc:statement[@refId='staticPerformanceLocation']/dcc:location"/></xsl:call-template></td>
                                <th>Certificate Number</th>
                                <td><xsl:call-template name="value-or-dash"><xsl:with-param name="value" select="$certificate-number"/></xsl:call-template></td>
                            </tr>
                        </tbody>
                    </table>

                    <h2>Information on Measurement Standard Apparatus and Reference Standards Used for Calibration</h2>
                    <table class="equipment-table" aria-label="Measurement Standard Apparatus and Reference Standards Used for Calibration">
                        <colgroup>
                            <col style="width:13.7%"/><col style="width:17.5%"/><col style="width:17.5%"/>
                            <col style="width:29.8%"/><col style="width:11.5%"/><col style="width:10%"/>
                        </colgroup>
                        <thead>
                            <tr>
                                <th>Category</th>
                                <th>Name</th>
                                <th>Measurement Range</th>
                                <th>Uncertainty / Accuracy Class / Maximum Permissible Error</th>
                                <th>Certificate Number</th>
                                <th>Valid Until</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:apply-templates select="$measurements/dcc:measuringEquipments/dcc:measuringEquipment[contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_standardWeightSet ')]" mode="equipment-row"/>
                        </tbody>
                    </table>

                    <h2 class="results-heading">Calibration Items and Results</h2>
                    <xsl:apply-templates select="$measurements/dcc:measurementResult[contains(concat(' ', normalize-space(@refType), ' '), ' NAWI_repeatabilityMeasurement ')]" mode="result-block"/>

                    <div class="folio">1</div>
                </article>

                <article class="sheet page-two">
                    <xsl:call-template name="running-head"/>

                    <xsl:apply-templates select="$measurements/dcc:measurementResult[contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_zeroSettingAccuracyAndWeighingMeasurement ')]" mode="result-block"/>
                    <xsl:apply-templates select="$measurements/dcc:measurementResult[contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_tareAccuracyAndWeighingMeasurement ')]" mode="result-block"/>
                    <xsl:apply-templates select="$measurements/dcc:measurementResult[contains(concat(' ', normalize-space(@refType), ' '), ' NAWI_eccentricityMeasurement ')]" mode="result-block"/>

                    <div class="folio">2</div>
                </article>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="running-head">
        <div class="running-head">
            <span class="running-code"><strong>JJG</strong><xsl:text> 1204—2025</xsl:text></span>
            <span class="schema-version">DCC <xsl:value-of select="@schemaVersion"/></span>
        </div>
    </xsl:template>

    <xsl:template match="dcc:measuringEquipment" mode="equipment-row">
        <xsl:variable name="quantities" select="dcc:measuringEquipmentQuantities/dcc:measuringEquipmentQuantity"/>
        <tr>
            <td class="equipment-kind">
                <xsl:choose>
                    <xsl:when test="contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_standardWeightSet ')">Reference Standard</xsl:when>
                    <xsl:otherwise>Measurement Standard Apparatus</xsl:otherwise>
                </xsl:choose>
            </td>
            <td><xsl:call-template name="localized-content"><xsl:with-param name="nodes" select="dcc:name/dcc:content"/></xsl:call-template></td>
            <td>
                <xsl:call-template name="real-value"><xsl:with-param name="real" select="$quantities[contains(concat(' ', normalize-space(@refType), ' '), ' math_minimum ')]/si:real"/></xsl:call-template>
                <xsl:text> ～ </xsl:text>
                <xsl:call-template name="real-value"><xsl:with-param name="real" select="$quantities[contains(concat(' ', normalize-space(@refType), ' '), ' math_maximum ')]/si:real"/></xsl:call-template>
            </td>
            <td class="equipment-quality">
                <xsl:call-template name="value-or-dash"><xsl:with-param name="value" select="dcc:equipmentClass[contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_accuracyClass ')]/dcc:classID"/></xsl:call-template>
                <xsl:if test="$quantities[contains(dcc:name, 'Uncertainty')]">
                    <span class="detail">
                        <xsl:text>U = </xsl:text>
                        <xsl:call-template name="real-value"><xsl:with-param name="real" select="$quantities[contains(dcc:name, 'Uncertainty')][1]/si:real"/></xsl:call-template>
                        <xsl:text> ～ </xsl:text>
                        <xsl:call-template name="real-value"><xsl:with-param name="real" select="$quantities[contains(dcc:name, 'Uncertainty')][last()]/si:real"/></xsl:call-template>
                        <xsl:if test="$quantities[contains(dcc:name, 'Uncertainty')][1]/dcc:description/dcc:content">
                            <xsl:text>(</xsl:text><xsl:value-of select="$quantities[contains(dcc:name, 'Uncertainty')][1]/dcc:description/dcc:content[1]"/><xsl:text>)</xsl:text>
                        </xsl:if>
                    </span>
                </xsl:if>
            </td>
            <td><xsl:call-template name="value-or-dash"><xsl:with-param name="value" select="dcc:identifications/dcc:identification[contains(concat(' ', normalize-space(@refType), ' '), ' basic_certificateNumber ')]/dcc:value"/></xsl:call-template></td>
            <td><xsl:call-template name="date-only"><xsl:with-param name="value" select="dcc:description[contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_standardValidityEndDate ')]/dcc:content"/></xsl:call-template></td>
        </tr>
    </xsl:template>

    <xsl:template match="dcc:measurementResult" mode="result-block">
        <xsl:variable name="title-rtf"><xsl:call-template name="localized-content"><xsl:with-param name="nodes" select="dcc:name/dcc:content"/></xsl:call-template></xsl:variable>
        <xsl:variable name="title" select="normalize-space(string($title-rtf))"/>
        <xsl:variable name="columns" select="dcc:results/dcc:result/dcc:data/dcc:list/dcc:quantity"/>
        <xsl:variable name="tracking" select="dcc:influenceConditions/dcc:influenceCondition[contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_zeroTrackingState ')]/dcc:data/dcc:text/dcc:content[@lang='zh']"/>
        <xsl:variable name="kind">
            <xsl:choose>
                <xsl:when test="contains(concat(' ', normalize-space(@refType), ' '), ' NAWI_repeatabilityMeasurement ')">repeat</xsl:when>
                <xsl:when test="contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_tareAccuracyAndWeighingMeasurement ')">tare</xsl:when>
                <xsl:when test="contains(concat(' ', normalize-space(@refType), ' '), ' NAWI_eccentricityMeasurement ')">eccentric</xsl:when>
                <xsl:otherwise>zero</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <section>
            <xsl:attribute name="class">result-block result-<xsl:value-of select="$kind"/></xsl:attribute>
            <div class="result-shell">
                <div class="result-meta">
                    <div class="result-title">
                        <xsl:value-of select="$title"/>
                        <span class="result-ref"><xsl:call-template name="localized-content"><xsl:with-param name="nodes" select="dcc:description/dcc:content"/></xsl:call-template></span>
                    </div>
                    <div class="tracking">
                        <span>Zero Tracking:</span>
                        <xsl:call-template name="tracking-option"><xsl:with-param name="label" select="'Operating'"/><xsl:with-param name="actual" select="$tracking"/></xsl:call-template>
                        <xsl:call-template name="tracking-option"><xsl:with-param name="label" select="'Not Operating'"/><xsl:with-param name="actual" select="$tracking"/></xsl:call-template>
                        <xsl:if test="string($kind) != 'repeat'">
                            <xsl:call-template name="tracking-option"><xsl:with-param name="label" select="'Outside Operating Range'"/><xsl:with-param name="actual" select="$tracking"/></xsl:call-template>
                        </xsl:if>
                    </div>
                    <div class="unit">
                        <span>Unit of Measurement:</span>
                        <xsl:call-template name="format-unit">
                            <xsl:with-param name="unit" select="$columns[(contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_tareLoad ') and ancestor::dcc:measurementResult[contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_tareAccuracyAndWeighingMeasurement ')]) or (contains(concat(' ', normalize-space(@refType), ' '), ' basic_nominalValue ') and not(ancestor::dcc:measurementResult[contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_tareAccuracyAndWeighingMeasurement ')]))]/descendant::*[self::si:unit or self::si:unitXMLList]"/>
                        </xsl:call-template>
                    </div>
                    <xsl:if test="string($kind) = 'tare'">
                        <div class="tare-line">
                            <xsl:text>Tare:</xsl:text>
                            <xsl:call-template name="real-value"><xsl:with-param name="real" select="$columns[contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_tareLoad ')]/si:real"/></xsl:call-template>
                        </div>
                    </xsl:if>
                </div>
                <xsl:call-template name="render-result-table">
                    <xsl:with-param name="columns" select="$columns"/>
                    <xsl:with-param name="kind" select="string($kind)"/>
                </xsl:call-template>
            </div>
            <xsl:if test="string($kind) = 'tare' or string($kind) = 'eccentric'">
                <div class="result-note">
                    <span>Note: *</span>
                    <span class="formula">The error E at this point shall satisfy |E₀| ≤ 0.25e.</span>
                </div>
            </xsl:if>
        </section>
    </xsl:template>

    <xsl:template name="render-result-table">
        <xsl:param name="columns"/>
        <xsl:param name="kind"/>
        <xsl:variable name="row-source" select="$columns[(contains(concat(' ', normalize-space(@refType), ' '), ' basic_indicationValue ') and ancestor::dcc:measurementResult[contains(concat(' ', normalize-space(@refType), ' '), ' NAWI_repeatabilityMeasurement ')]) or (contains(concat(' ', normalize-space(@refType), ' '), ' basic_nominalValue ') and not(ancestor::dcc:measurementResult[contains(concat(' ', normalize-space(@refType), ' '), ' NAWI_repeatabilityMeasurement ')]))]"/>
        <xsl:variable name="row-count-rtf">
            <xsl:choose>
                <xsl:when test="$row-source/si:realListXMLList/si:valueXMLList">
                    <xsl:call-template name="count-tokens"><xsl:with-param name="text" select="$row-source/si:realListXMLList/si:valueXMLList"/></xsl:call-template>
                </xsl:when>
                <xsl:otherwise><xsl:value-of select="count($row-source/dcc:noQuantity/dcc:content)"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="row-count" select="number($row-count-rtf)"/>

        <table>
            <xsl:attribute name="class">result-table table-<xsl:value-of select="$kind"/></xsl:attribute>
            <xsl:attribute name="aria-label"><xsl:call-template name="localized-content"><xsl:with-param name="nodes" select="dcc:name/dcc:content"/></xsl:call-template></xsl:attribute>
            <xsl:choose>
                <xsl:when test="$kind='repeat'">
                    <colgroup><col style="width:7%"/><col style="width:13%"/><col style="width:15%"/><col style="width:18%"/><col style="width:14%"/><col style="width:17%"/><col style="width:16%"/></colgroup>
                </xsl:when>
                <xsl:when test="$kind='tare'">
                    <colgroup><col style="width:10%"/><col style="width:10%"/><col style="width:9%"/><col style="width:9%"/><col style="width:9%"/><col style="width:9%"/><col style="width:9%"/><col style="width:9%"/><col style="width:9%"/><col style="width:9%"/><col style="width:8%"/></colgroup>
                </xsl:when>
                <xsl:when test="$kind='eccentric'">
                    <colgroup><col style="width:10%"/><col style="width:15%"/><col style="width:15%"/><col style="width:15%"/><col style="width:12%"/><col style="width:21%"/><col style="width:12%"/></colgroup>
                </xsl:when>
                <xsl:otherwise>
                    <colgroup><col style="width:17%"/><col style="width:17%"/><col style="width:18%"/><col style="width:14%"/><col style="width:22%"/><col style="width:12%"/></colgroup>
                </xsl:otherwise>
            </xsl:choose>
            <thead>
                <xsl:choose>
                    <xsl:when test="$kind='tare'">
                        <tr>
                            <th rowspan="2">Tare Load<span class="symbol">T</span></th>
                            <th rowspan="2">Load<span class="symbol">L</span></th>
                            <th colspan="2">Indication<span class="symbol">I</span></th>
                            <th colspan="2">Additional Load<span class="symbol">ΔL</span></th>
                            <th colspan="2">Error<span class="symbol">E</span></th>
                            <th colspan="2">Corrected Error / Result Assessment<span class="symbol">E<sub>c</sub></span></th>
                            <th rowspan="2">MPE</th>
                        </tr>
                        <tr class="subhead">
                            <th>Loading ↓</th><th>Unloading ↑</th>
                            <th>Loading ↓</th><th>Unloading ↑</th>
                            <th>Loading ↓</th><th>Unloading ↑</th>
                            <th>Loading ↓</th><th>Unloading ↑</th>
                        </tr>
                    </xsl:when>
                    <xsl:otherwise>
                        <tr>
                            <xsl:if test="$kind='repeat'"><th>Trial</th></xsl:if>
                            <xsl:for-each select="$columns">
                                <th><xsl:call-template name="column-head"/></th>
                            </xsl:for-each>
                        </tr>
                    </xsl:otherwise>
                </xsl:choose>
            </thead>
            <tbody>
                <xsl:choose>
                    <xsl:when test="$row-count &gt; 0">
                        <xsl:call-template name="render-result-rows">
                            <xsl:with-param name="columns" select="$columns"/>
                            <xsl:with-param name="kind" select="$kind"/>
                            <xsl:with-param name="row-count" select="$row-count"/>
                            <xsl:with-param name="index" select="1"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <tr><td colspan="99">—</td></tr>
                    </xsl:otherwise>
                </xsl:choose>
            </tbody>
        </table>
    </xsl:template>

    <xsl:template name="render-result-rows">
        <xsl:param name="columns"/>
        <xsl:param name="kind"/>
        <xsl:param name="row-count"/>
        <xsl:param name="index"/>
        <xsl:if test="$index &lt;= $row-count">
            <tr>
                <xsl:if test="$kind='repeat'"><td class="row-index"><xsl:value-of select="$index"/></td></xsl:if>
                <xsl:for-each select="$columns">
                    <xsl:call-template name="data-cell">
                        <xsl:with-param name="index" select="$index"/>
                        <xsl:with-param name="row-count" select="$row-count"/>
                        <xsl:with-param name="column-position" select="position()"/>
                        <xsl:with-param name="kind" select="$kind"/>
                    </xsl:call-template>
                </xsl:for-each>
            </tr>
            <xsl:call-template name="render-result-rows">
                <xsl:with-param name="columns" select="$columns"/>
                <xsl:with-param name="kind" select="$kind"/>
                <xsl:with-param name="row-count" select="$row-count"/>
                <xsl:with-param name="index" select="$index + 1"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template name="data-cell">
        <xsl:param name="index"/>
        <xsl:param name="row-count"/>
        <xsl:param name="column-position"/>
        <xsl:param name="kind"/>
        <xsl:choose>
            <xsl:when test="si:real and $index &gt; 1"/>
            <xsl:otherwise>
                <td>
                    <xsl:if test="si:real and $row-count &gt; 1">
                        <xsl:attribute name="rowspan"><xsl:value-of select="$row-count"/></xsl:attribute>
                    </xsl:if>
                    <xsl:if test="$index=1 and contains(concat(' ', normalize-space(@refType), ' '), ' basic_measurementError ') and ($kind!='tare' or contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_loading '))">
                        <sup class="marker">*</sup>
                    </xsl:if>
                    <xsl:choose>
                        <xsl:when test="si:realListXMLList/si:valueXMLList">
                            <xsl:call-template name="token-at"><xsl:with-param name="text" select="si:realListXMLList/si:valueXMLList"/><xsl:with-param name="index" select="$index"/></xsl:call-template>
                        </xsl:when>
                        <xsl:when test="dcc:noQuantity/dcc:content">
                            <xsl:call-template name="position-value"><xsl:with-param name="value" select="dcc:noQuantity/dcc:content[$index]"/></xsl:call-template>
                        </xsl:when>
                        <xsl:when test="si:real"><xsl:value-of select="si:real/si:value"/></xsl:when>
                        <xsl:otherwise>—</xsl:otherwise>
                    </xsl:choose>
                </td>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="column-head">
        <xsl:variable name="name-rtf">
            <xsl:choose>
                <xsl:when test="dcc:name"><xsl:call-template name="localized-content"><xsl:with-param name="nodes" select="dcc:name/dcc:content"/></xsl:call-template></xsl:when>
                <xsl:otherwise><xsl:call-template name="localized-content"><xsl:with-param name="nodes" select="dcc:noQuantity/dcc:name/dcc:content"/></xsl:call-template></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="name" select="normalize-space(string($name-rtf))"/>
        <xsl:choose>
            <xsl:when test="contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_tareLoad ')">Tare Load</xsl:when>
            <xsl:when test="contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_additionalLoad ')">Additional Load</xsl:when>
            <xsl:when test="contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_correctedError ')">Corrected Error / Result Assessment</xsl:when>
            <xsl:when test="contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_maximumPermissibleError ') or contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_absoluteMaximumPermissibleError ')">Maximum Permissible Error</xsl:when>
            <xsl:when test="contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_repeatabilityValue ')">Repeatability</xsl:when>
            <xsl:when test="contains(concat(' ', normalize-space(@refType), ' '), ' basic_indicationValue ')">Indication</xsl:when>
            <xsl:when test="contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_additionalLoad ')">Additional Load</xsl:when>
            <xsl:when test="contains(concat(' ', normalize-space(@refType), ' '), ' basic_measurementError ')">Error</xsl:when>
            <xsl:when test="contains(concat(' ', normalize-space(@refType), ' '), ' basic_nominalValue ')">Load</xsl:when>
            <xsl:otherwise><xsl:value-of select="$name"/></xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_tareLoad ')"><span class="symbol">T</span></xsl:when>
            <xsl:when test="contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_additionalLoad ')"><span class="symbol">ΔL</span></xsl:when>
            <xsl:when test="contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_correctedError ')"><span class="symbol">E<sub>c</sub></span></xsl:when>
            <xsl:when test="contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_maximumPermissibleError ') or contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_absoluteMaximumPermissibleError ')"><span class="symbol"><xsl:if test="contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_absoluteMaximumPermissibleError ')">|</xsl:if>MPE<xsl:if test="contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_absoluteMaximumPermissibleError ')">|</xsl:if></span></xsl:when>
            <xsl:when test="contains(concat(' ', normalize-space(@refType), ' '), ' jjg1204_repeatabilityValue ')"><span class="symbol">E<sub>R</sub></span></xsl:when>
            <xsl:when test="contains(concat(' ', normalize-space(@refType), ' '), ' basic_indicationValue ')"><span class="symbol">I</span></xsl:when>
            <xsl:when test="contains(concat(' ', normalize-space(@refType), ' '), ' basic_measurementError ')"><span class="symbol">E</span></xsl:when>
            <xsl:when test="contains(concat(' ', normalize-space(@refType), ' '), ' basic_nominalValue ')"><span class="symbol">L</span></xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="tracking-option">
        <xsl:param name="label"/>
        <xsl:param name="actual"/>
        <span class="check-option">
            <xsl:value-of select="$label"/>
            <span>
                <xsl:attribute name="class">box<xsl:if test="normalize-space($actual)=normalize-space($label)"> checked</xsl:if></xsl:attribute>
            </span>
        </span>
    </xsl:template>

    <xsl:template name="localized-content">
        <xsl:param name="nodes"/>
        <xsl:choose>
            <xsl:when test="$nodes[@lang='zh']"><xsl:value-of select="$nodes[@lang='zh'][1]"/></xsl:when>
            <xsl:when test="$nodes[not(@lang)]"><xsl:value-of select="$nodes[not(@lang)][1]"/></xsl:when>
            <xsl:when test="$nodes[@lang='en']"><xsl:value-of select="$nodes[@lang='en'][1]"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="$nodes[1]"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="value-or-dash">
        <xsl:param name="value"/>
        <xsl:choose>
            <xsl:when test="string-length(normalize-space(string($value))) &gt; 0"><xsl:value-of select="$value"/></xsl:when>
            <xsl:otherwise>—</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="real-value">
        <xsl:param name="real"/>
        <xsl:choose>
            <xsl:when test="$real/si:value">
                <xsl:value-of select="$real/si:value"/>
                <xsl:if test="$real/si:unit">
                    <xsl:text> </xsl:text><xsl:call-template name="format-unit"><xsl:with-param name="unit" select="$real/si:unit"/></xsl:call-template>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>—</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="format-unit">
        <xsl:param name="unit"/>
        <xsl:choose>
            <xsl:when test="normalize-space($unit)='\kilogram'">kg</xsl:when>
            <xsl:when test="normalize-space($unit)='\gram'">g</xsl:when>
            <xsl:when test="normalize-space($unit)='\degreeCelsius'">℃</xsl:when>
            <xsl:when test="string-length(normalize-space($unit))=0">—</xsl:when>
            <xsl:otherwise><xsl:value-of select="$unit"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="location">
        <xsl:param name="node"/>
        <xsl:choose>
            <xsl:when test="$node">
                <xsl:if test="$node/dcc:countryCode"><xsl:value-of select="$node/dcc:countryCode"/><xsl:text> · </xsl:text></xsl:if>
                <xsl:value-of select="$node/dcc:city"/>
                <xsl:if test="$node/dcc:street"><xsl:text> </xsl:text><xsl:value-of select="$node/dcc:street"/></xsl:if>
                <xsl:if test="$node/dcc:streetNo"><xsl:value-of select="$node/dcc:streetNo"/></xsl:if>
                <xsl:if test="$node/dcc:postCode"><xsl:text>(</xsl:text><xsl:value-of select="$node/dcc:postCode"/><xsl:text>)</xsl:text></xsl:if>
            </xsl:when>
            <xsl:otherwise>—</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="date-only">
        <xsl:param name="value"/>
        <xsl:choose>
            <xsl:when test="contains($value, 'T')"><xsl:value-of select="substring-before($value, 'T')"/></xsl:when>
            <xsl:when test="string-length(normalize-space($value)) &gt; 0"><xsl:value-of select="$value"/></xsl:when>
            <xsl:otherwise>—</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="count-tokens">
        <xsl:param name="text"/>
        <xsl:param name="count" select="0"/>
        <xsl:variable name="normalized" select="normalize-space($text)"/>
        <xsl:choose>
            <xsl:when test="$normalized=''"><xsl:value-of select="$count"/></xsl:when>
            <xsl:when test="contains($normalized, ' ')">
                <xsl:call-template name="count-tokens"><xsl:with-param name="text" select="substring-after($normalized, ' ')"/><xsl:with-param name="count" select="$count + 1"/></xsl:call-template>
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="$count + 1"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="token-at">
        <xsl:param name="text"/>
        <xsl:param name="index"/>
        <xsl:variable name="normalized" select="normalize-space($text)"/>
        <xsl:choose>
            <xsl:when test="$index=1"><xsl:value-of select="substring-before(concat($normalized, ' '), ' ')"/></xsl:when>
            <xsl:when test="contains($normalized, ' ')">
                <xsl:call-template name="token-at"><xsl:with-param name="text" select="substring-after($normalized, ' ')"/><xsl:with-param name="index" select="$index - 1"/></xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="position-value">
        <xsl:param name="value"/>
        <xsl:choose>
            <xsl:when test="starts-with(normalize-space($value), 'Position ') and contains(substring-after(normalize-space($value), 'Position '), ':')">
                <xsl:value-of select="substring-before(substring-after(normalize-space($value), 'Position '), ':')"/>
            </xsl:when>
            <xsl:when test="starts-with(normalize-space($value), 'Position ')"><xsl:value-of select="substring-after(normalize-space($value), 'Position ')"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="$value"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
