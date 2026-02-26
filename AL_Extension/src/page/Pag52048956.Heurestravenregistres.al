page 52048956 "Heures trav. enregistrées"
{//GL2024  ID dans Nav 2009 : "39001477"
    DeleteAllowed = false;

    InsertAllowed = false;
    //  ModifyAllowed = false;
    PageType = List;
    SourceTable = "Heures occa. enreg. m";
    SourceTableView = sorting("N° transaction", "N° Ligne", "N° Salarié")
                      order(ascending);
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Heures trav. enregistrées';
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
                    Visible = false;
                }
                field("N° Salarié"; Rec."N° Salarié")
                {
                    Editable = false;
                    Caption = 'N° Salarié';
                    ApplicationArea = Basic;
                }
                field("Prénom +' ' + ""Nom usuel"""; Rec.Prénom + ' ' + Rec."Nom usuel")
                {
                    Editable = false;
                    ApplicationArea = Basic;
                    Caption = 'Nom salarié';
                }
                field("Type Jours"; Rec."Type Jours")
                {
                    Editable = true;
                    ApplicationArea = Basic;
                    Caption = 'Type Jours';
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                    ApplicationArea = Basic;
                    Caption = 'Date';
                }
                field("Nombre Jours Prime Panier"; Rec."Nombre Jours Prime Panier") { ApplicationArea = all; }
                field("Taux de majoration"; Rec."Taux de majoration") { ApplicationArea = all; }
                // field(Kmetrage; Rec.Kmetrage)
                // {
                //     Editable = false;
                //     ApplicationArea = Basic;
                //     Caption = 'Kmetrage';
                //     Style = Strong;
                //     StyleExpr = true;
                // }

                field(section; Rec.section)
                {
                    Editable = false;
                    ApplicationArea = Basic;
                    Caption = 'Affectation';
                }
                field(Quinzaine; Rec.Quinzaine)
                {
                    Editable = false;
                    ApplicationArea = Basic;
                    Caption = 'Quinzaine';
                    Visible = false;
                }
                field(Semaine; Rec.Semaine)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Caption = 'Semaine';
                }
                field("Année de paiement"; Rec."Année de paiement")
                {
                    Editable = false;
                    ApplicationArea = Basic;
                    Caption = 'Année de paiement';
                }
                field("Mois de paiement"; Rec."Mois de paiement")
                {
                    Editable = true;
                    ApplicationArea = Basic;
                    Caption = 'Mois de paiement';
                    Visible = true;
                }
                field("Nombre d'heures"; Rec."Nombre d'heures")
                {
                    Editable = false;
                    ApplicationArea = Basic;
                    Caption = 'Nombre d''heures';
                }
                field("Nbre Jour"; Rec."Nbre Jour")
                {
                    Editable = false;
                    ApplicationArea = Basic;
                    Caption = 'Nbre Jour';
                    Style = Unfavorable;
                    StyleExpr = true;
                    Visible = true;
                }
                // field("Jours Deplacement"; Rec."Jours Deplacement")
                // {
                //     Editable = false;
                //     ApplicationArea = Basic;
                //     Caption = 'Jours Deplacement';
                // }
                // field(Rappel; Rec.Rappel)
                // {
                //     Editable = false;
                //     ApplicationArea = Basic;
                //     Caption = 'Rappel';
                // }
                // field(Retenu; Rec.Retenu)
                // {
                //     Editable = false;
                //     ApplicationArea = Basic;
                //     Caption = 'Retenu';
                // }
                // field(Cession; Rec.Cession)
                // {
                //     Editable = false;
                //     ApplicationArea = Basic;
                //     Caption = 'Cession';
                // }
                // field("Jours Travaillé"; Rec."Jours Travaillé")
                // {
                //     Editable = false;
                //     ApplicationArea = Basic;
                //     Caption = 'Jours Travaillé';
                // }
                // field("Heure Travaillé"; Rec."Heure Travaillé")
                // {
                //     Editable = false;
                //     ApplicationArea = Basic;
                //     Caption = 'Heure Travaillé';
                // }
                field("Tarif unitaire"; Rec."Tarif unitaire")
                {
                    Editable = false;
                    ApplicationArea = Basic;
                    Caption = 'Tarif unitaire';
                }
                field("Montant ligne"; Rec."Montant ligne")
                {
                    Editable = false;
                    Caption = 'Montant ligne';
                    ApplicationArea = Basic;
                }
            }
            group(Control31)
            {
                ShowCaption = false;
                Editable = false;
                field(Control34; Rec."N° Salarié")
                {
                    Caption = 'N° Salarié';
                    ApplicationArea = Basic;
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
                    Caption = 'Mois de paiement';
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Control33; Rec."Année de paiement")
                {
                    Caption = 'Année de paiement';
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group("Fonction&s1")
            {
                Caption = 'Fonction&s';
                actionref(Imprimer1; Imprimer) { }
                actionref(Devalider1; Devalider) { }
            }

        }
        area(navigation)
        {
            group("Fonction&s")
            {
                Caption = 'Fonction&s';
                action(Imprimer)
                {
                    ApplicationArea = Basic;
                    Caption = 'Imprimer';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Report.Run(Report::"Employee - Unions", true, false, Rec);
                    end;
                }
                action(Devalider)
                {
                    ApplicationArea = Basic;
                    Caption = 'Devalider';

                    trigger OnAction()
                    var
                        HeuresSup: Record "Heures occasionnelles";
                        Wind: Dialog;
                        Saved: Record "Heures occa. enreg. m";
                        Nligne: Integer;
                        Hcode: Codeunit "Management of Work Hours";
                        conf: label 'Vous êtes sur le point de dévalider les lignes sélectionnées.';
                    begin

                        HeuresSup.Reset;
                        HeuresSup.SetCurrentkey("N° Ligne");
                        if HeuresSup.Find('+') then
                            Nligne := HeuresSup."N° Ligne" + 10000
                        else
                            Nligne := 10000;


                        CurrPage.SetSelectionFilter(Saved);
                        IF SalaireEnregistrer.GET(Saved."Paiement No.", Saved."N° Salarié") THEN EXIT;
                        // Saved.SetFilter("Paiement No.", '=''''');
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
                                    Hcode.DevaliderHeuresTravail(Saved, Nligne);
                                    Nligne := Nligne + 10000;
                                until Saved.Next = 0;
                        Wind.Close;
                    end;
                }
            }
        }
    }

    var
        "Salarié": Record Employee;
        "ListeSalarié": Page "Employee List";
        SalaireEnregistrer: Record "Rec. Salary Lines";

    local procedure Salari233NoOnAfterValidate()
    begin
        Rec.SetFilter("N° Salarié", Salarié."No.");
        CurrPage.Update;
    end;
}

