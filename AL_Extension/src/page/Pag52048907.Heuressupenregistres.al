page 52048907 "Heures sup. enregistrées"
{
    //GL2024  ID dans Nav 2009 : "39001428"
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;

    PageType = List;
    SourceTable = "Heures sup. eregistrées m";
    SourceTableView = sorting("N° transaction", "N° Ligne", "N° Salarié")
                      order(ascending);
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Heures sup. enregistrées';
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Général';
                field("Salarié.""No."""; Salarié."No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Filtre N° salarié';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        // MC : Filtre salarié

                        Clear(ListeSalarié);
                        ListeSalarié.LookupMode := true;
                        if ListeSalarié.RunModal = Action::LookupOK
                          then begin
                            ListeSalarié.GetRecord(Salarié);
                            //MESSAGE (Salarié.Prénom +' '+ Salarié."Nom usuel");
                        end;
                        Rec.SetFilter("N° Salarié", Salarié."No.");
                        CurrPage.Update;
                    end;

                    trigger OnValidate()
                    begin
                        Salari233NoOnAfterValidate;
                    end;
                }

            }
            repeater(Control1)
            {
                ShowCaption = false;
                field("Paiement No."; Rec."Paiement No.")
                {
                    Editable = false;
                    ApplicationArea = Basic;
                    Caption = 'Paiement No.';
                }

                field("Date comptabilisation"; Rec."Date comptabilisation")
                {
                    Editable = false;
                    ApplicationArea = Basic;
                    Caption = 'Date comptabilisation';
                }
                field("N° Ligne"; Rec."N° Ligne")
                {
                    Editable = false;
                    ApplicationArea = Basic;
                    Caption = 'N° Ligne';
                }
                field("N° Salarié"; Rec."N° Salarié")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                    Caption = 'N° Salarié';
                    Editable = false;
                }
                field("Prénom +' ' + ""Nom usuel"""; Rec.Prénom + ' ' + Rec."Nom usuel")
                {
                    Editable = false;
                    ApplicationArea = Basic;
                    Caption = 'Nom salarié';
                }
                field("Type heure"; Rec."Type heure")
                {
                    Editable = false;
                    ApplicationArea = Basic;
                    Caption = 'Type heure';
                }
                field("Type Jours"; Rec."Type Jours")
                {
                    Editable = true;
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    Caption = 'Type Jours';
                    StyleExpr = true;
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                    ApplicationArea = Basic;
                }
                field(Quinzaine; Rec.Quinzaine)
                {
                    Editable = false;
                    ApplicationArea = Basic;
                    Caption = 'Quinzaine';
                }
                field(Semaine; Rec.Semaine)
                {
                    Editable = false;
                    ApplicationArea = Basic;
                    Caption = 'Semaine';
                }
                field("Mois de paiement"; Rec."Mois de paiement")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Mois de paiement';
                }
                field("Année de paiement"; Rec."Année de paiement")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Année de paiement';
                }
                field("Nombre d'heures"; Rec."Nombre d'heures")
                {
                    ApplicationArea = Basic;
                    Caption = 'Nombre d''heures';
                    Editable = false;
                }

                field("Tarif unitaire"; Rec."Tarif unitaire")
                {
                    ApplicationArea = Basic;
                    Caption = 'Tarif unitaire';
                }
                field("Taux de majoration"; Rec."Taux de majoration")
                {
                    ApplicationArea = all;
                }

                // field(Affectation; Rec.Affectation)
                // {
                //     Editable = false;
                //     Caption = 'Affectation';
                //     ApplicationArea = Basic;
                //     Style = Strong;
                //     StyleExpr = true;
                // }



                // field("Nombre Jours Supp"; Rec."Nombre Jours Supp")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Nombre Jours Supp';
                // }
                // field("Nombre Heures Supp"; Rec."Nombre Heures Supp")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Nombre Heures Supp';
                // }
                field("Montant Ligne"; Rec."Montant Ligne")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Montant Ligne';
                }

            }
            group(Control31)
            {
                ShowCaption = false;
                field(Control34; Rec."N° Salarié")
                {
                    ApplicationArea = Basic;
                    Caption = 'N° Salarié';
                    Editable = false;
                }
                field("Prénom +  ' ' + ""Nom usuel"""; Rec.Prénom + ' ' + Rec."Nom usuel")
                {
                    ApplicationArea = Basic;
                    Caption = 'Nom salarié';
                    Editable = false;
                }
                field(Control30; Rec."Mois de paiement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mois de paiement';
                    Editable = false;
                }
                field(Control33; Rec."Année de paiement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Année de paiement';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {

            actionref(Imprimer1; Imprimer) { }
            actionref(Devalider1; Devalider) { }

        }
        area(navigation)
        {

            action(Imprimer)
            {
                ApplicationArea = Basic;
                Caption = 'Imprimer';
                Visible = false;

                trigger OnAction()
                begin
                    Report.Run(Report::"Tableau Amortissement Prêt en@", true, false, Rec);
                end;
            }
            action(Devalider)
            {
                ApplicationArea = Basic;
                Caption = 'Devalider';

                trigger OnAction()
                var
                    conf: label 'Are sur to unvalidate the selected lines.';
                    HeuresSup: Record "Heures sup. m";
                    Nligne: Integer;
                begin

                    HeuresSup.Reset;
                    HeuresSup.SetCurrentkey("N° Ligne");
                    if HeuresSup.Find('+') then
                        Nligne := HeuresSup."N° Ligne" + 10000
                    else
                        Nligne := 10000;

                    CurrPage.SetSelectionFilter(Saved);
                    //Saved.SETFILTER("Paiement No.",'=''''');
                    Wind.Open('De validation de Heures Supplémentaire : \' +
                              ' Salariée  #1########################### \' +
                              ' N° Ligne              #2############### \' +
                              ' Date Heure Supplémentaire  #3########## ');
                    if Saved.Find('-') then
                        if Confirm(conf) then
                            repeat
                                Wind.Update(1, Saved."N° Salarié" + ' ' + Saved."Nom usuel");
                                Wind.Update(2, Nligne);
                                Wind.Update(3, Saved.Date);
                                Hcode.DevaliderHeuresSup(Saved, Nligne);
                                Nligne := Nligne + 10000;
                            until Saved.Next = 0;
                    Wind.Close;
                end;

            }
        }
    }

    var
        "Salarié": Record Employee;
        "ListeSalarié": Page "Employee List";
        Saved: Record "Heures sup. eregistrées m";
        Hcode: Codeunit "Management of Work Hours";
        Wind: Dialog;

    local procedure Salari233NoOnAfterValidate()
    begin
        Rec.SetFilter("N° Salarié", Salarié."No.");
        CurrPage.Update;
    end;
}

