page 52048881 "Config. Social Contributions"
{
    //GL2024  ID dans Nav 2009 : "39001402"
    Caption = 'Config. Social Contributions';
    PageType = List;
    SourceTable = "Social Contribution";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Libellé; rec.Libellé)
                {
                    ApplicationArea = all;
                }
                field("Mode dévaluation"; rec."Mode dévaluation")
                {
                    ApplicationArea = all;
                }
                field("Employee's part"; rec."Employee's part")
                {
                    ApplicationArea = all;
                }
                field("Forfait salarial"; rec."Forfait salarial")
                {
                    ApplicationArea = all;
                }
                field("Deductible of taxable basis"; rec."Deductible of taxable basis")
                {
                    ApplicationArea = all;
                }
                field("Employer's part"; rec."Employer's part")
                {
                    ApplicationArea = all;
                }
                field("Basis of calculation"; rec."Basis of calculation")
                {
                    ApplicationArea = all;
                }
                field("Employee : G/L Account"; rec."Employee : G/L Account")
                {
                    ApplicationArea = all;
                }
                field("Employer : G/L Account"; rec."Employer : G/L Account")
                {
                    ApplicationArea = all;
                }
                field("Employer : Bal. Account No."; rec."Employer : Bal. Account No.")
                {
                    ApplicationArea = all;
                }
                field("Non Inclus en Prime"; rec."Non Inclus en Prime")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("non inclus en compta"; rec."non inclus en compta")
                {
                    ApplicationArea = all;
                    Visible = false;
                }

            }
        }
    }
    actions
    {
        area(Promoted)
        {
            group("F&unctions1")
            {
                Caption = 'F&unctions';
                actionref("Fiche Cotisations sociales1"; "Fiche Cotisations sociales")
                {

                }


                actionref("MAJ Contrats de travail1"; "MAJ Contrats de travail")
                {

                }
            }

        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Fiche Cotisations sociales")
                {
                    ApplicationArea = all;
                    Caption = 'Fiche Cotisations sociales';
                    RunObject = page "Card : Social Contribution";
                    RunPageLink = Code = FIELD(Code);
                }
                separator(separator100)
                {
                }
                action("MAJ Contrats de travail")
                {
                    ApplicationArea = all;
                    Caption = 'MAJ Contrats de travail';

                    trigger OnAction()
                    var
                        DefaultCot: Record "Default Soc. Contribution";
                        Soc: record "Social Contribution";
                    begin
                        Soc.RESET;
                        IF Soc.FIND('-') THEN
                            REPEAT
                                DefaultCot.RESET;
                                DefaultCot.SETRANGE("Social Contribution Code", Soc.Code);
                                IF DefaultCot.FIND('-') THEN
                                    REPEAT
                                        DefaultCot."Employer's part" := Soc."Employer's part";
                                        DefaultCot."Employee's part" := Soc."Employee's part";
                                        DefaultCot."Basis of calculation" := Soc."Basis of calculation";
                                        DefaultCot."Deductible of taxable basis" := Soc."Deductible of taxable basis";

                                        DefaultCot."Mode dévaluation" := Soc."Mode dévaluation";

                                        DefaultCot."Maximum value - Employee" := Soc."Maximum value - Employee";
                                        DefaultCot."Maximum value - Employer" := Soc."Maximum value - Employer";

                                        DefaultCot."Mode dévaluation" := Soc."Mode dévaluation";
                                        DefaultCot."Forfait salarial" := Soc."Forfait salarial";
                                        DefaultCot."Forfait patronal" := Soc."Forfait patronal";

                                        DefaultCot."Employer's part" := Soc."Employer's part";
                                        DefaultCot."Employee's part" := Soc."Employee's part";

                                        DefaultCot."User ID" := USERID;
                                        DefaultCot."Last Date Modified" := WORKDATE;
                                        DefaultCot."Non inclus en compta" := Soc."non inclus en compta";
                                        DefaultCot."Non Inclus en Prime" := Soc."Non Inclus en Prime";

                                        DefaultCot.MODIFY;
                                    UNTIL DefaultCot.NEXT = 0;
                            UNTIL Soc.NEXT = 0;
                    end;
                }
            }
        }
    }
}

