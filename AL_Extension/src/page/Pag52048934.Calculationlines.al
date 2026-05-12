page 52048934 "Calculation lines"
{
    //GL2024  ID dans Nav 2009 : "39001455"
    Caption = 'Lignes de calcul';
    Editable = true;
    InsertAllowed = false;
    PageType = Listpart;
    SourceTable = "Salary Lines";
    //ABZApplicationArea = all;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Control1180250000)
            {
                ShowCaption = false;
                Editable = true;
                field(Employee; Rec.Employee)
                {
                    ApplicationArea = Basic;
                    Caption = 'Salarié';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Nom';
                }
                // field(Chantier; Rec.Chantier)
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                // }
                // field(Affectation; Rec.Affectation)
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                // }
                // field(Qualification; Rec.Qualification)
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                // }
                // field("Salaire Net sur fiche"; Rec."Salaire Net sur fiche")
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                //     Style = Strong;
                //     StyleExpr = true;
                // }
                field(Fonction; Rec.Fonction)
                {
                    ApplicationArea = Basic;
                    Caption = 'Fonction';
                    Editable = false;
                }
                field("Statistics Group Code"; Rec."Statistics Group Code")
                {
                    ApplicationArea = Basic;
                    //  Caption = 'Groupe Statistique';
                    Editable = false;
                }
                field("Statistic Gpe Descrip"; Rec."Statistic Gpe Descrip")
                {
                    ApplicationArea = Basic;
                    // Caption = 'Description Groupe Statistique';
                    Editable = false;
                }
                field(Service; Rec.Service)
                {
                    ApplicationArea = Basic;
                    Caption = 'Service';
                    Editable = false;
                }
                field("Description Service"; Rec."Description Service")
                {
                    ApplicationArea = Basic;
                    Caption = 'Description Service';
                    Editable = false;
                }
                field("Paied days"; Rec."Paied days")
                {
                    ApplicationArea = Basic;
                    Caption = 'Jours payés';
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Code Mode Réglement"; Rec."Code Mode Réglement")
                {
                    ApplicationArea = all;
                    Caption = 'Mode Réglement';
                }
                field("Num Compte"; rec."Num Compte")
                {
                    ApplicationArea = all;
                    Caption = 'Banque';
                }
                // field(RIB; Rec.RIB)
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                //     Style = Strong;
                //     StyleExpr = true;
                // }
                field("Catégorie"; Rec.Catégorie)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                    Visible = false;
                }
                // field("Contribution Social"; Rec."Contribution Social")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Net salary cashed"; Rec."Net salary cashed")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire net perçu';
                    Editable = false;
                    Visible = false;
                }
                // field(Rappel; Rec.Rappel)
                // {
                //     ApplicationArea = Basic;
                //     Editable = true;
                // }
                // field(Retenu; Rec.Retenu)
                // {
                //     ApplicationArea = Basic;
                //     Editable = true;
                // }
                // field(Cession; Rec.Cession)
                // {
                //     ApplicationArea = Basic;
                //     Editable = true;
                // }
                field("droit de congé du mois"; Rec."droit de congé du mois")
                {
                    ApplicationArea = Basic;
                    Caption = 'Droit Congé Mois';
                    Editable = false;
                    Enabled = true;
                    Visible = false;
                }
                // field("Droit Acquis Par Ancienneté"; Rec."Droit Acquis Par Ancienneté")
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                // }
                // field("Motif STC"; Rec."Motif STC")
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                // }
                field(Absences; Rec.Absences)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;

                }
                field("congé"; Rec.congé)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Basis salary"; Rec."Basis salary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire de base';
                    Visible = false;
                    Editable = false;
                }
                field("Gross Salary"; Rec."Gross Salary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire Brut';
                    Editable = false;
                }
                // field("Exclu Declaration CNSS"; Rec."Exclu Declaration CNSS")
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                //     Style = Strong;
                //     StyleExpr = true;
                // }
                field("Taxe (Month)"; Rec."Taxe (Month)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Impôt (Mois)';
                    Visible = false;
                    DecimalPlaces = 0 : 0;
                    Editable = false;
                }
                field(CNSS; Rec.CNSS)
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    Visible = false;
                    Editable = false;
                }
                field("Deduction Family chief"; Rec."Deduction Family chief")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Caption = 'Déduction Chef de famille';
                }
                field("Net salary"; Rec."Net salary")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    DecimalPlaces = 0 : 0;
                    Caption = 'Salaire net';
                    Editable = false;
                }

                field("Ajout  en +"; Rec."Ajout  en +")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Report en -"; Rec."Report en -")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Base Imposable"; rec."Base Imposable")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 2;
                }
                field(Abattement; rec.Abattement)
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 2;
                }
                field(Exonération; rec.Exonération)
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 2;
                }
                field("Salaire Net Imposable"; rec."Salaire Net Imposable")
                {
                    ApplicationArea = all;
                }
                field("IUTS Brut"; Rec."IUTS Brut") { ApplicationArea = all; DecimalPlaces = 3 : 2; }
                field("IUTS Net"; Rec."IUTS Net") { ApplicationArea = all; DecimalPlaces = 3 : 2; }
                field("Net salary1"; Rec."Net salary")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    Caption = 'Salaire net';
                    Editable = false;
                }

                field("Retenue FSP1"; Rec."Retenue FSP")
                {

                    Style = Attention;
                    StyleExpr = true;
                    ApplicationArea = all;
                    DecimalPlaces = 0 : 0;
                }
                field("Retenue SNP1"; Rec."Retenue SNP")
                {
                    Style = StandardAccent;
                    DecimalPlaces = 0 : 0;
                    StyleExpr = true;
                    ApplicationArea = all;
                }

                field(Loans; Rec.Loans)
                {
                    Caption = 'Prêts';
                    ApplicationArea = Basic;

                    Editable = false;
                    //Visible = false;
                }
                field(Advances; Rec.Advances)
                {


                    Caption = 'Avances';
                    ApplicationArea = Basic;
                    //Visible = false;
                    Editable = false;
                }
                field(Control1180250073; Rec."Net salary cashed")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire net perçu';
                    Visible = false;
                    DecimalPlaces = 0 : 0;

                }
                field(NetSalaryCashed21; Rec."Net salary cashed")
                {
                    Caption = 'Salaire net perçu';
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    Style = AttentionAccent;
                    StyleExpr = true;
                    Editable = false;
                }
                field("Salaire Net Contrat"; Rec."Salaire Net Contrat")
                {
                    ToolTip = 'Specifies the value of the Salaire Net Contrat field.', Comment = '%';
                    StyleExpr = SNetContrat;
                    DecimalPlaces = 0 : 0;
                }
                field("Num Mobile Money"; Rec."Num Mobile Money")
                {
                    ToolTip = 'Specifies the value of the Num Mobile Money field.', Comment = '%';
                }
                field(Control11802500731; Rec."Net salary cashed")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire net perçu';
                    Visible = false;
                    DecimalPlaces = 0 : 0;
                    Editable = false;
                }
                // field("Congé Pri"; Rec."Congé Pri")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Congé';
                //     Editable = false;
                //     Style = Strong;
                //     StyleExpr = true;
                // }
                // field("Férier"; Rec.Férier)
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                //     Style = Strong;
                //     StyleExpr = true;
                // }
                // field("Congé Spéciale"; Rec."Congé Spéciale")
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                //     Style = Strong;
                //     StyleExpr = true;
                // }
                // field("Description Qualification Sala"; Rec."Description Qualification Sala")
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                //     Style = Strong;
                //     StyleExpr = true;
                // }
            }
            group("Salary line")
            {
                Caption = 'Ligne de salaire';
                Editable = false;
                field(Name2; Rec.Employee + ' - ' + Rec.Name)
                {
                    ShowCaption = false;
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field(Control1180250082; Rec."Gross Salary")
                {
                    Caption = 'Salaire Brut';
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                }
                field("Base Imposable1"; rec."Base Imposable")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 0 : 0;
                }
                field(Abattement1; rec.Abattement)
                {
                    ApplicationArea = all;
                    DecimalPlaces = 0 : 0;
                }
                field(Exonération1; rec.Exonération)
                {
                    ApplicationArea = all;
                    DecimalPlaces = 0 : 0;
                }
                field(TPA; Rec.TPA)
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 2;
                }

                field("Salaire Net Imposable1"; rec."Salaire Net Imposable")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 0 : 0;
                }
                field("Base Imposable Avec 8%"; rec."Base Imposable Avec 8%")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 2;
                }
                field("Net salary11"; Rec."Net salary")
                {
                    ApplicationArea = Basic;

                    DecimalPlaces = 0 : 0;
                    Caption = 'Salaire Net Imposable Avec 8%';
                    Editable = false;
                }
                field("IUTS Net1"; Rec."IUTS net") { ApplicationArea = all; DecimalPlaces = 0 : 0; }

                field("Salaire Net Imposable Avec 8%"; rec."Salaire Net Imposable Avec 8%")
                {
                    Caption = 'Salaire net';
                    ApplicationArea = all;
                    DecimalPlaces = 0 : 0;
                }
                field(Control1000000020; Rec.CNSS)
                {
                    Caption = 'CNSS';
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Taxable salary"; Rec."Taxable salary")
                {
                    Caption = 'Salaire imposable';
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    Visible = false;
                }
                field(Control1180250086; Rec."Taxe (Month)")
                {
                    Caption = 'Impôt (Mois)';
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    Visible = false;
                }
                field(Control1180250088; Rec."Net salary")
                {
                    Caption = 'Salaire net';
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    Visible = false;
                }
                field("Retenue FSP"; Rec."Retenue FSP") { ApplicationArea = all; Visible = false; }
                field("Retenue SNP"; Rec."Retenue SNP") { ApplicationArea = all; Visible = false; }
                field(Control1000000008; Rec.Loans)
                {
                    Caption = 'Prêts';
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field(Control1000000010; Rec.Advances)
                {
                    Caption = 'Avances';
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                // field(Control1000000032; Rec."Contribution Social")
                // {
                //     Caption = 'Contribution Social';
                //     ApplicationArea = Basic;
                //     Style = Strong;
                //     StyleExpr = true;
                // }
                // field("Credit Habitat"; Rec."Credit Habitat")
                // {
                //     Caption = 'Credit Habitat';
                //     ApplicationArea = Basic;
                //     Style = Unfavorable;
                //     StyleExpr = true;
                // }
                field(NetSalaryCashed2; Rec."Net salary cashed")
                {
                    Caption = 'Salaire net perçu';
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 0;
                    Style = AttentionAccent;
                    StyleExpr = true;
                    Editable = false;
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
        T1.SetFilter("No.", Rec."No.");
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
        if Rec."Net salary cashed" < 0 then begin end
    end;

    local procedure NameOnFormat()
    begin
        if Rec."Net salary cashed" < 0 then begin end
    end;

    local procedure Employee43393943NameOnFormat()
    begin
        if Rec."Net salary cashed" < 0 then begin
            pictVisible := true;
        end
        else begin
            pictVisible := false;
        end;
        if rec."Net salary" <> rec."Salaire Net Contrat" then
            SNetContrat := 'UNFAVORABLE'
        else
            SNetContrat := 'FAVORABLE';
    end;

    local procedure NetsalarycashedC1180250090OnFo()
    begin

        /*IF "Net salary cashed" < 0 THEN BEGIN END
         ELSE
          CurrPage.NetSalaryCashed2.UPDATEFORECOLOR (0)    */

    end;

    var
        SNetContrat: Text;
}

