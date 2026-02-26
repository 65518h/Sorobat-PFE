Page 50263 "Contribution Social de Calsul"
{
    Editable = false;
    PageType = List;
    SourceTable = "Social Contributions";
    ApplicationArea = all;
    Caption = 'Contribution Social de Calsul';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; REC."No.")
                {
                    ApplicationArea = all;
                }
                field(Employee; REC.Employee)
                {
                    ApplicationArea = all;
                }
                field("Employee Posting Group"; REC."Employee Posting Group")
                {
                    ApplicationArea = all;
                }
                field(Indemnity; REC.Indemnity)
                {
                    ApplicationArea = all;
                }
                field("Social Contribution"; REC."Social Contribution")
                {
                    ApplicationArea = all;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                }
                field("Employer's part"; REC."Employer's part")
                {
                    ApplicationArea = all;
                }
                field("Employee's part"; REC."Employee's part")
                {
                    ApplicationArea = all;
                }
                field("Basis of calculation"; REC."Basis of calculation")
                {
                    ApplicationArea = all;
                }
                field("Base Amount"; REC."Base Amount")
                {
                    ApplicationArea = all;
                }
                field("Real Amount : Employee"; REC."Real Amount : Employee")
                {
                    ApplicationArea = all;
                }
                field("Real Amount : Employer"; REC."Real Amount : Employer")
                {
                    ApplicationArea = all;
                }
                field("Deductible of taxable basis"; REC."Deductible of taxable basis")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1"; REC."Global Dimension 1")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 2"; REC."Global Dimension 2")
                {
                    ApplicationArea = all;
                }
                field("Real Amount : Employee PR"; REC."Real Amount : Employee PR")
                {
                    ApplicationArea = all;
                }
                field("year of Calculate"; REC."year of Calculate")
                {
                    ApplicationArea = all;
                }
                field("Maximum value - Employee"; REC."Maximum value - Employee")
                {
                    ApplicationArea = all;
                }
                field("Maximum value - Employer"; REC."Maximum value - Employer")
                {
                    ApplicationArea = all;
                }
                field("Mode dévaluation"; REC."Mode dévaluation")
                {
                    ApplicationArea = all;
                }
                field("Forfait salarial"; REC."Forfait salarial")
                {
                    ApplicationArea = all;
                }
                field("Forfait patronal"; REC."Forfait patronal")
                {
                    ApplicationArea = all;
                }
                // field("Non Cotisable"; REC."Non Cotisable")
                // {
                //     ApplicationArea = all;
                // }
                field("User ID"; REC."User ID")
                {
                    ApplicationArea = all;
                }
                field("Last Date Modified"; REC."Last Date Modified")
                {
                    ApplicationArea = all;
                }
                field("6 * Smig"; REC."6 * Smig")
                {
                    ApplicationArea = all;
                }
                field("inclus en compta"; REC."inclus en compta")
                {
                    ApplicationArea = all;
                }
                field("Employee Statistic Group"; REC."Employee Statistic Group")
                {
                    ApplicationArea = all;
                }
                field(direction; REC.direction)
                {
                    ApplicationArea = all;
                }
                field(service; REC.service)
                {
                    ApplicationArea = all;
                }
                field(section; REC.section)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

