page 52048879 Indemnity
{
    //GL2024  ID dans Nav 2009 : "39001400"
    Caption = 'Liste des indemnités';
    PageType = List;
    SourceTable = Indemnity;
    ApplicationArea = all;
    UsageCategory = Lists;
    DelayedInsert = true;
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
                field(Type; rec.Type)
                {
                    ApplicationArea = all;
                }
                field("Evaluation mode"; rec."Evaluation mode")
                {
                    ApplicationArea = all;
                }
                // field("Non Cotisable"; rec."Non Cotisable")
                // {
                //     ApplicationArea = all;
                // }
                // field("Non Imposable"; rec."Non Imposable")
                // {
                //     ApplicationArea = all;
                // }

                field("Type STC"; rec."Type STC")
                {
                    ApplicationArea = all;
                }
                field("Non Inclus en Calcul CNSS"; rec."Non Inclus en Calcul CNSS")
                {
                    ApplicationArea = all;
                }
                field("Inclu Calcul Brut STC"; rec."Inclu Calcul Brut STC")
                {
                    ApplicationArea = all;
                }
                field("Non Inclue en jours férier"; rec."Non Inclue en jours férier")
                {
                    ApplicationArea = all;
                }
                // field("Panier Au Prorata Deplacement"; rec."Panier Au Prorata Deplacement")
                // {
                //     ApplicationArea = all;
                // }
                // field("Inclus Base Calcul Ferié-Congé"; rec."Inclus Base Calcul Ferié-Congé")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Non Inclis en jours férier';
                // }
                // field("Inclure Calcul Exo Impot"; rec."Inclure Calcul Exo Impot")
                // {
                //     ApplicationArea = all;
                // }
                // field(STC; rec.STC)
                // {
                //     ApplicationArea = all;
                // }
                // field("Ferié Congé Inclus Jours Payés"; rec."Ferié Congé Inclus Jours Payés")
                // {
                //     ApplicationArea = all;
                // }
                // field("Min Comptabilisable"; rec."Min Comptabilisable")
                // {
                //     ApplicationArea = all;
                // }
                field("Inclus dans heures supp"; rec."Inclus dans heures supp")
                {
                    ApplicationArea = all;
                }
                field("Inclus dans heures supp1"; rec."Inclus dans heures supp")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Default amount"; rec."Default amount")
                {
                    ApplicationArea = all;
                }
                // field(Acquis; rec.Acquis)
                // {
                //     ApplicationArea = all;
                // }
                field("Nombre de jours"; rec."Nombre de jours")
                {
                    ApplicationArea = all;
                }
                field("Non Inclus en Prime1"; rec."Non Inclus en Prime")
                {
                    ApplicationArea = all;
                }
                field("% salaire de base"; rec."% salaire de base")
                {
                    ApplicationArea = all;
                }
                field("Taux % salaire de base"; rec."Taux % salaire de base")
                {
                    ApplicationArea = all;
                }
                field("Precision Arrondi Montant"; rec."Precision Arrondi Montant")
                {
                    ApplicationArea = all;
                }
                field("Non Inclue en jours congé"; rec."Non Inclue en jours congé")
                {
                    ApplicationArea = all;
                }
                field(Taux; rec.Taux)
                {
                    ApplicationArea = all;
                }
                field("Indemnité conventionnelle"; rec."Indemnité conventionnelle")
                {
                    ApplicationArea = all;
                }
                field("Non Inclis en AV NAt"; rec."Non Inclis en AV NAt")
                {
                    ApplicationArea = all;
                }
                field("Type Indemnité"; rec."Type Indemnité")
                {
                    ApplicationArea = all;
                }
                field("Non Inclus en Prime"; rec."Non Inclus en Prime")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Minimum value"; rec."Minimum value")
                {
                    ApplicationArea = all;
                }
                field("Inclus dans base assurance"; rec."Inclus dans base assurance")
                {
                    ApplicationArea = all;
                }
                field("Direction Arrondi"; rec."Direction Arrondi")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Precision Arrondi Montant1"; rec."Precision Arrondi Montant")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Direction Arrondi1"; rec."Direction Arrondi")
                {
                    ApplicationArea = all;
                }
                field("Inclus dans heures supp2"; rec."Inclus dans heures supp")
                {
                    ApplicationArea = all;
                }
                field("base deduction indemnité/jours"; rec."base deduction indemnité/jours")
                {
                    ApplicationArea = all;
                }
                field("Avantage en nature"; rec."Avantage en nature")
                {
                    ApplicationArea = all;
                }
                field("Non déductible accident de Tra"; rec."Non déductible accident de Tra")
                {
                    ApplicationArea = all;
                }
                field("Compte indemnité"; rec."Compte indemnité")
                {
                    ApplicationArea = all;
                }
                field("Compte contre partie indemnité"; rec."Compte contre partie indemnité")
                {
                    ApplicationArea = all;
                }
                // field("Inclus Base Calcul Ferié-Congé1"; rec."Inclus Base Calcul Ferié-Congé")
                // {
                //     ApplicationArea = all;
                // }
                // field("Non Cotisable1"; rec."Non Cotisable")
                // {
                //     ApplicationArea = all;
                // }
                // field(Retraite; rec.Retraite)
                // {
                //     ApplicationArea = all;
                // }
            }
        }
    }

    actions
    {
        area(Promoted)
        {

            group(Indemnity1)
            {
                Caption = 'Indemnity';
                actionref(Fiche1; Fiche)
                {

                }
            }

            group("Fonction&s1")
            {
                Caption = 'Fonction&s';
                actionref("MAJ : Désignation + Paramètres1"; "MAJ : Désignation + Paramètres")
                {

                }

                actionref("Creer Indemnité1"; "Creer Indemnité")
                {

                }
            }
        }
        area(navigation)
        {
            group(Indemnity)
            {
                Caption = 'Indemnity';
                Visible = true;
                /*GL2024 action("Cotisation sociale")
                 {
                     ApplicationArea = all;
                     Caption = 'Cotisation sociale';
                     //GL3900   RunObject = page "Soc. Contribution per Ind.";
                     //GL3900 RunPageLink = "Indemnity Code" = FIELD(Code);
                 }*/
                action(Fiche)
                {
                    ApplicationArea = all;
                    Caption = 'Fiche';
                    RunObject = page "Fiche indemnité";
                    RunPageLink = Code = FIELD(Code);
                    RunPageView = SORTING(Code) ORDER(Ascending);
                }
            }
            group("Fonction&s")
            {
                Caption = 'Fonction&s';
                action("MAJ : Désignation + Paramètres")
                {
                    ApplicationArea = all;
                    Caption = 'MAJ : Désignation + Paramètres';

                    trigger OnAction()
                    begin
                        Test := TRUE;

                        IF Ind.FIND('-') THEN
                            REPEAT
                                Def.RESET;
                                Def.SETRANGE("Indemnity Code", Ind.Code);
                                IF Def.FIND('-') THEN
                                    REPEAT
                                        Def.Description := Ind.Description;
                                        Def.Type := Ind.Type;
                                        Def."Evaluation mode" := Ind."Evaluation mode";
                                        Def."Non Inclus en Prime" := Ind."Non Inclus en Prime";
                                        Def."non inclus en compta" := Ind."non inclus en compta";
                                        Def."Precision Arrondi Montant" := Ind."Precision Arrondi Montant";
                                        Def."Direction Arrondi" := Ind."Direction Arrondi";
                                        Def."Type Indemnité" := Ind."Type Indemnité";
                                        //MBY 23/01/2012
                                        Def.VALIDATE("Default amount", Ind."Default amount");
                                        //MBY 23/01/2012
                                        Def."Inclus dans heures supp" := Ind."Inclus dans heures supp";
                                        Def."Indemnité conventionnelle" := Ind."Indemnité conventionnelle";
                                        IF Def.MODIFY
                                          THEN
                                            Test := TRUE
                                        ELSE
                                            Test := FALSE;
                                        Test := Test AND Test;
                                    UNTIL Def.NEXT = 0;
                            UNTIL Ind.NEXT = 0;

                        IF Test THEN
                            MESSAGE('Opération de mise à jour effectuée avec succés !')
                        ELSE
                            ERROR('Ereur lors de la procédure de Mise à jour.')
                    end;
                }
                separator(separator100)
                {
                }
                action("Creer Indemnité")
                {
                    ApplicationArea = all;
                    Caption = 'Creer Indemnité';

                    trigger OnAction()
                    begin
                        DefTmp.RESET;
                        CLEAR(Frm);
                        DefTmp.SETFILTER("Indemnity Code", rec.Code);
                        Frm.SETTABLEVIEW(DefTmp);
                        Frm.RUNMODAL;
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;

    var
        Def: Record "Default Indemnities";
        Ind: record Indemnity;
        Test: Boolean;
        Frm: page "Employment Contracts List Ind";//39001418
        DefTmp: Record "Default Indemnities";
}

