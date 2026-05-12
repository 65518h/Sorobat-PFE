Page 50261 "Ligne Salaire"
{
    Caption = 'Ligne Salaire';
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Salary Lines";
    //ABZ ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1180250000)
            {
                Editable = true;
                ShowCaption = false;
                field("No."; REC."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Employee; REC.Employee)
                {
                    ApplicationArea = all;
                }
                field(Name; REC.Name)
                {
                    ApplicationArea = all;
                }
                // field(Chantier; REC.Chantier)
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                // field(Affectation; REC.Affectation)
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                // field(Qualification; REC.Qualification)
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                field("Catégorie"; REC.Catégorie)
                {
                    ApplicationArea = all;
                }
                field("Paied days"; REC."Paied days")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Net salary cashed"; REC."Net salary cashed")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                // field(Rappel; REC.Rappel)
                // {
                //     ApplicationArea = all;
                //     Editable = true;
                // }
                // field(Retenu; REC.Retenu)
                // {
                //     ApplicationArea = all;
                //     Editable = true;
                // }
                // field(Cession; REC.Cession)
                // {
                //     ApplicationArea = all;
                //     Editable = true;
                // }
                field("droit de congé du mois"; REC."droit de congé du mois")
                {
                    ApplicationArea = all;
                    Caption = 'Droit Congé Mois';
                    Editable = false;
                    Enabled = true;
                }
                // field("Droit Acquis Par Ancienneté"; REC."Droit Acquis Par Ancienneté")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                // field("Motif STC"; REC."Motif STC")
                // {
                //     ApplicationArea = all;
                // }
                field(Absences; REC.Absences)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("congé"; REC.congé)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Basis salary"; REC."Basis salary")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Real basis salary"; REC."Real basis salary")
                {
                    ApplicationArea = all;
                }
                field("Gross Salary"; REC."Gross Salary")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Taxe (Month)"; REC."Taxe (Month)")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                    Editable = false;
                }
                // field("Contribution Social"; REC."Contribution Social")
                // {
                //     ApplicationArea = all;
                // }
                field(CNSS; REC.CNSS)
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                    Editable = false;
                }
                field("Deduction Family chief"; REC."Deduction Family chief")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Net salary"; REC."Net salary")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                    Editable = false;
                }
                field(Loans; REC.Loans)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Advances; REC.Advances)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Ajout  en +"; REC."Ajout  en +")
                {
                    ApplicationArea = all;
                }
                field("Report en -"; REC."Report en -")
                {
                    ApplicationArea = all;
                }
                field(Control1180250073; REC."Net salary cashed")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                    Editable = false;
                }
            }
            group("Salary line")
            {
                Caption = 'Salary line';
                Editable = false;
                field(Name2; REC.Employee + ' - ' + REC.Name)
                {
                    ApplicationArea = all;
                    ShowCaption = false;
                    MultiLine = true;
                }
                field(Control1180250082; REC."Gross Salary")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                }
                field(Control1000000020; REC.CNSS)
                {
                    ApplicationArea = all;
                }
                field("Taxable salary"; REC."Taxable salary")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                }
                field(Control1180250086; REC."Taxe (Month)")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                }
                field(Control1180250088; REC."Net salary")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                }
                field(Control1000000008; REC.Loans)
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field(Control1000000010; REC.Advances)
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                // field(Control1000000032; REC."Contribution Social")
                // {
                //     ApplicationArea = all;
                //     Style = Strong;
                //     StyleExpr = true;
                // }
                // field("Credit Habitat"; REC."Credit Habitat")
                // {
                //     ApplicationArea = all;
                //     Style = Unfavorable;
                //     StyleExpr = true;
                // }
                field(NetSalaryCashed2; REC."Net salary cashed")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                    Style = Strong;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        EmployeeOnFormat;
        NameOnFormat;
        Employee43393943NameOnFormat;
        NetsalarycashedC1180250090OnFo;
    end;

    trigger OnInit()
    begin
        pictVisible := true;
    end;

    var
        HumResPara: Record "Human Resources Setup";
        [InDataSet]
        pictVisible: Boolean;


    procedure ChangerModePaiement(var Mode: Option Virement,"Espèse")
    var
        compteclt: Record "Employee Bank Account";
        clt: Record Employee;
        T1: Record "Salary Lines";
    begin
        T1.Reset;
        T1.SetFilter("No.", REC."No.");
        CurrPage.SetSelectionFilter(T1);
        if T1.Find('-') then
            repeat
                Clear(clt);
                clt.Get(T1.Employee);
                case Mode of
                    0:
                        begin
                            Clear(compteclt);
                            if compteclt.Get(T1.Employee, clt."Default Bank Account Code") then begin
                                T1."Bank Account Code" := clt."Default Bank Account Code";
                                T1."Num Compte" := compteclt."Bank Account No.";
                                //    T1."Code Mode Réglement":= Mode;
                                T1.Modify;
                            end;
                        end;
                    1:
                        begin
                            T1."Bank Account Code" := '';
                            T1."Num Compte" := '';
                            //      T1."Code Mode Réglement":= Mode;
                            T1.Modify;
                        end;
                end;
                T1."Code Mode Réglement" := Mode;
                T1.Modify;

            until T1.Next = 0;
    end;

    local procedure EmployeeOnFormat()
    begin
        if REC."Net salary cashed" < 0 then begin end
    end;

    local procedure NameOnFormat()
    begin
        if REC."Net salary cashed" < 0 then begin end
    end;

    local procedure Employee43393943NameOnFormat()
    begin
        if REC."Net salary cashed" < 0 then begin
            pictVisible := true;
        end
        else begin
            pictVisible := false;
        end
    end;

    local procedure NetsalarycashedC1180250090OnFo()
    begin
        //GL2024
        /*IF "Net salary cashed" < 0 THEN BEGIN END
         ELSE
          CurrPage.NetSalaryCashed2.UPDATEFORECOLOR (0)  */

    end;
}

