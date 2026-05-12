page 50782 "Entete Pointage Salarier MAN"
{
    PageType = Card;
    SourceTable = "Entete Pointage Salarier Man";
    //SourceTableView = SORTING("N°")
    //                  WHERE(Validé = CONST(false));
    ApplicationArea = all;
    UsageCategory = Administration;
    Caption = 'Entete Pointage Salarier Manuelle';
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'Général';

                field("N°"; rec."N°")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Chantier; Rec.Chantier)
                {
                    ToolTip = 'Specifies the value of the Chantier field.', Comment = '%';
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }
                field("Année"; Rec."Année")
                {
                    ToolTip = 'Specifies the value of the Année field.', Comment = '%';
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field(Mois; Rec.Mois)
                {
                    ToolTip = 'Specifies the value of the Mois field.', Comment = '%';
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Total Effectif"; Rec."Total Effectif")
                {
                    ToolTip = 'Specifies the value of the Total Effectif field.', Comment = '%';
                    Style = Strong;
                    StyleExpr = TRUE;
                    Editable = false;
                }
                field("Seuil Jours de Pointage"; Rec."Seuil Jours de Pointage")
                {
                    ToolTip = 'Specifies the value of the Seuil Jours de Pointage field.', Comment = '%';
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    Editable = EDITABLESeuil;
                }
            }
            part(Lines; "Subform Ligne Pointag Sala M")
            {
                ApplicationArea = all;
                Editable = true;
                SubPageLink = "N°" = FIELD("N°");
            }
        }
    }
    actions
    {
        area(processing)
        {
            /* action(Valider)
             {
                 ApplicationArea = all;
                 Caption = 'Valider';
                 Promoted = true;
                 PromotedCategory = Process;

                 trigger OnAction()
                 begin
                     IF NOT CONFIRM(Text003, FALSE) THEN EXIT;
                     rec.Validé := TRUE;
                     rec.MODIFY;
                     MESSAGE(Text002);
                 end;
             }*/
            action(Actualiser)
            {
                ApplicationArea = all;
                Caption = 'Actualiser';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //Currpage.Lines.FORM.EDITABLE(TRUE);
                    "RecSalarié".RESET();
                    "RecSalarié".SETRANGE("RecSalarié".Chantier, rec.Chantier); 
                    "RecSalarié".SETRANGE("RecSalarié".Blocked, False);
                    "RecSalarié".SETRANGE("RecSalarié".BR, False);
                    IF "RecSalarié".FINDFIRST THEN BEGIN
                        REPEAT
                            "RecLignePointage 2".Reset();
                            "RecLignePointage 2".SetRange("RecLignePointage 2"."N°", rec."N°");
                            "RecLignePointage 2".SETRANGE("RecLignePointage 2".Matricule, "RecSalarié"."No.");
                            IF "RecLignePointage 2".FINDFIRST THEN BEGIN
                            END
                            ELSE BEGIN
                                "RecLignePointage"."N°" := rec."N°";
                                "RecLignePointage".Matricule := "RecSalarié"."No.";
                                GRecSalary.Reset;
                                if GRecSalary.Get("RecSalarié"."No.") then begin
                                    GRecSalary.CalcFields("Deccription Affectation");
                                    GRecSalary.CalcFields("Description Qualification");
                                    "RecLignePointage".Nom := GRecSalary."First Name" + ' ' + GRecSalary."Last Name";
                                    "RecLignePointage".Affectation := GRecSalary.Affectation;
                                    "RecLignePointage".Qualification := GRecSalary.Qualification;
                                    "RecLignePointage"."Description Affectation" := GRecSalary."Deccription Affectation";
                                    "RecLignePointage"."Description Qualification" := GRecSalary."Description Qualification";
                                end;
                                "RecLignePointage".INSERT;
                            END;
                        UNTIL "RecSalarié".NEXT = 0;
                        MESSAGE('Insertion Terminé');
                    END;
                END;
            }
            action("Importation Pointage")
            {
                ApplicationArea = all;
                Caption = 'Importation Pointage';
                Promoted = true;
                PromotedCategory = Process;
                Visible = EDITABLESeuil;

                trigger OnAction()
                var
                 //   XMLImport: XmlPort "Import Ligne Pointage";
                begin
                    // XMLImport.SetNo(Rec."N°");
                    // XMLImport.RUN();
                end;
            }
            action("Update Calcul Ligne")
            {
                ApplicationArea = all;
                Caption = 'Update Calcul Ligne';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    RecLignePointage3.RESET;
                    RecLignePointage3.SETRANGE(RecLignePointage3."N°", rec."N°");
                    IF RecLignePointage3.FINDFIRST then
                        repeat
                            Presence();
                        until RecLignePointage3.NEXT = 0;
                    MESSAGE('Update des lignes Terminé');
                END;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
    begin
        EDITABLESeuil := FALSE;
        RecUserSetup.RESET;
        IF RecUserSetup.GET(UserId) THEN begin
          //  IF RecUserSetup."Autor Seuil pointage Salarier" = TRUE THEN EDITABLESeuil := TRUE;
        END;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        rec."N°" := NoSeriesMgt.GetNextNo('PSAL-PMANU', 0D, TRUE);
        rec."Année" := Date2DMY(TODAY, 3);
        Rec.Mois := Date2DMY(TODAY, 2);
        //rec.Utilisateur := USERID;
        // rec.Chantier := 'AIN-ZAGHOUEN';
    end;

    procedure Presence()
    var
        JoursPres: Decimal;
        JoursCongé: Decimal;
        JoursABS: Integer;
        JoursFérié: Integer;
        JoursCongéEXP: Decimal;
        TotalHeurePre: Decimal;
        MaChaine: Text;
        MonDecimal: Decimal;
        JoursPointage: Integer;
    begin
        JoursPres := 0;
        JoursCongé := 0;
        JoursFérié := 0;
        JoursABS := 0;
        JoursCongéEXP := 0;
        TotalHeurePre := 0;
        JoursPointage := 0;
        //************** "1" ****************
        MaChaine := RecLignePointage3."1";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."1" = 'P') OR (RecLignePointage3."1" = 'AU') OR (RecLignePointage3."1" = 'P-R') OR (RecLignePointage3."1" = 'MISS') OR (RecLignePointage3."1" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."1" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."1" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."1" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."1" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."1" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "1" ****************
        //************** "2" ****************
        MaChaine := RecLignePointage3."2";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."2" = 'P') OR (RecLignePointage3."2" = 'AU') OR (RecLignePointage3."2" = 'P-R') OR (RecLignePointage3."2" = 'MISS') OR (RecLignePointage3."2" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."2" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."2" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."2" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."2" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."2" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "2" ****************
        //************** "3" ****************
        MaChaine := RecLignePointage3."3";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."3" = 'P') OR (RecLignePointage3."3" = 'AU') OR (RecLignePointage3."3" = 'P-R') OR (RecLignePointage3."3" = 'MISS') OR (RecLignePointage3."3" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."3" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."3" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."3" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."3" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."3" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "3" ****************
        //************** "4" ****************
        MaChaine := RecLignePointage3."4";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."4" = 'P') OR (RecLignePointage3."4" = 'AU') OR (RecLignePointage3."4" = 'P-R') OR (RecLignePointage3."4" = 'MISS') OR (RecLignePointage3."4" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."4" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."4" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."4" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."4" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."4" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "4" ****************
        //************** "5" ****************
        MaChaine := RecLignePointage3."5";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."5" = 'P') OR (RecLignePointage3."5" = 'AU') OR (RecLignePointage3."5" = 'P-R') OR (RecLignePointage3."5" = 'MISS') OR (RecLignePointage3."5" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."5" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."5" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."5" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."5" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."5" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "5" ****************
        //************** "6" ****************
        MaChaine := RecLignePointage3."6";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."6" = 'P') OR (RecLignePointage3."6" = 'AU') OR (RecLignePointage3."6" = 'P-R') OR (RecLignePointage3."6" = 'MISS') OR (RecLignePointage3."6" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."6" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."6" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."6" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."6" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."6" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "6" ****************
        //************** "7" ****************
        MaChaine := RecLignePointage3."7";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."7" = 'P') OR (RecLignePointage3."7" = 'AU') OR (RecLignePointage3."7" = 'P-R') OR (RecLignePointage3."7" = 'MISS') OR (RecLignePointage3."7" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."7" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."7" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."7" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."7" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."7" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "7" ****************
        //************** "8" ****************
        MaChaine := RecLignePointage3."8";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."8" = 'P') OR (RecLignePointage3."8" = 'AU') OR (RecLignePointage3."8" = 'P-R') OR (RecLignePointage3."8" = 'MISS') OR (RecLignePointage3."8" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."8" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."8" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."8" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."8" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."8" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "8" ****************
        //************** "9" ****************
        MaChaine := RecLignePointage3."9";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."9" = 'P') OR (RecLignePointage3."9" = 'AU') OR (RecLignePointage3."9" = 'P-R') OR (RecLignePointage3."9" = 'MISS') OR (RecLignePointage3."9" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."9" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."9" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."9" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."9" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."9" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "9" ****************
        //************** "10" ****************
        MaChaine := RecLignePointage3."10";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."10" = 'P') OR (RecLignePointage3."10" = 'AU') OR (RecLignePointage3."10" = 'P-R') OR (RecLignePointage3."10" = 'MISS') OR (RecLignePointage3."10" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."10" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."10" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."10" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."10" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."10" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "10" ****************
        //************** "11" ****************
        MaChaine := RecLignePointage3."11";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."11" = 'P') OR (RecLignePointage3."11" = 'AU') OR (RecLignePointage3."11" = 'P-R') OR (RecLignePointage3."11" = 'MISS') OR (RecLignePointage3."11" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."11" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."11" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."11" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."11" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."11" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "11" ****************
        //************** "12" ****************
        MaChaine := RecLignePointage3."12";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."12" = 'P') OR (RecLignePointage3."12" = 'AU') OR (RecLignePointage3."12" = 'P-R') OR (RecLignePointage3."12" = 'MISS') OR (RecLignePointage3."12" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."12" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."12" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."12" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."12" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."12" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "12" ****************
        //************** "13" ****************
        MaChaine := RecLignePointage3."13";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."13" = 'P') OR (RecLignePointage3."13" = 'AU') OR (RecLignePointage3."13" = 'P-R') OR (RecLignePointage3."13" = 'MISS') OR (RecLignePointage3."13" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."13" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."13" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."13" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."13" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."13" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "13" ****************
        //************** "14" ****************
        MaChaine := RecLignePointage3."14";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."14" = 'P') OR (RecLignePointage3."14" = 'AU') OR (RecLignePointage3."14" = 'P-R') OR (RecLignePointage3."14" = 'MISS') OR (RecLignePointage3."14" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."14" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."14" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."14" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."14" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."14" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "14" ****************
        //************** "15" ****************
        MaChaine := RecLignePointage3."15";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."15" = 'P') OR (RecLignePointage3."15" = 'AU') OR (RecLignePointage3."15" = 'P-R') OR (RecLignePointage3."15" = 'MISS') OR (RecLignePointage3."15" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."15" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."15" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."15" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."15" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."15" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "15" ****************
        //************** "16" ****************
        MaChaine := RecLignePointage3."16";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."16" = 'P') OR (RecLignePointage3."16" = 'AU') OR (RecLignePointage3."16" = 'P-R') OR (RecLignePointage3."16" = 'MISS') OR (RecLignePointage3."16" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."16" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."16" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."16" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."16" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."16" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "16" ****************
        //************** "17" ****************
        MaChaine := RecLignePointage3."17";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."17" = 'P') OR (RecLignePointage3."17" = 'AU') OR (RecLignePointage3."17" = 'P-R') OR (RecLignePointage3."17" = 'MISS') OR (RecLignePointage3."17" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."17" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."17" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."17" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."17" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."17" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "17" ****************
        //************** "18" ****************
        MaChaine := RecLignePointage3."18";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."18" = 'P') OR (RecLignePointage3."18" = 'AU') OR (RecLignePointage3."18" = 'P-R') OR (RecLignePointage3."18" = 'MISS') OR (RecLignePointage3."18" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."18" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."18" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."18" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."18" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."18" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "18" ****************
        //************** "19" ****************
        MaChaine := RecLignePointage3."19";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."19" = 'P') OR (RecLignePointage3."19" = 'AU') OR (RecLignePointage3."19" = 'P-R') OR (RecLignePointage3."19" = 'MISS') OR (RecLignePointage3."19" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."19" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."19" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."19" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."19" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."19" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "19" ****************
        //************** "20" ****************
        MaChaine := RecLignePointage3."20";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."20" = 'P') OR (RecLignePointage3."20" = 'AU') OR (RecLignePointage3."20" = 'P-R') OR (RecLignePointage3."20" = 'MISS') OR (RecLignePointage3."20" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."20" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."20" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."20" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."20" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."20" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "20" ****************
        //************** "21" ****************
        MaChaine := RecLignePointage3."21";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."21" = 'P') OR (RecLignePointage3."21" = 'AU') OR (RecLignePointage3."21" = 'P-R') OR (RecLignePointage3."21" = 'MISS') OR (RecLignePointage3."21" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."21" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."21" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."21" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."21" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."21" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "21" ****************
        //************** "22" ****************
        MaChaine := RecLignePointage3."22";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."22" = 'P') OR (RecLignePointage3."22" = 'AU') OR (RecLignePointage3."22" = 'P-R') OR (RecLignePointage3."22" = 'MISS') OR (RecLignePointage3."22" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."22" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."22" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."22" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."22" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."22" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "22" ****************
        //************** "23" ****************
        MaChaine := RecLignePointage3."23";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."23" = 'P') OR (RecLignePointage3."23" = 'AU') OR (RecLignePointage3."23" = 'P-R') OR (RecLignePointage3."23" = 'MISS') OR (RecLignePointage3."23" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."23" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."23" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."23" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."23" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."23" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "23" ****************
        //************** "24" ****************
        MaChaine := RecLignePointage3."24";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."24" = 'P') OR (RecLignePointage3."24" = 'AU') OR (RecLignePointage3."24" = 'P-R') OR (RecLignePointage3."24" = 'MISS') OR (RecLignePointage3."24" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."24" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."24" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."24" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."24" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."24" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "24" ****************
        //************** "25" ****************
        MaChaine := RecLignePointage3."25";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."25" = 'P') OR (RecLignePointage3."25" = 'AU') OR (RecLignePointage3."25" = 'P-R') OR (RecLignePointage3."25" = 'MISS') OR (RecLignePointage3."25" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."25" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."25" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."25" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."25" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."25" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "25" ****************
        //************** "26" ****************
        MaChaine := RecLignePointage3."26";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."26" = 'P') OR (RecLignePointage3."26" = 'AU') OR (RecLignePointage3."26" = 'P-R') OR (RecLignePointage3."26" = 'MISS') OR (RecLignePointage3."26" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."26" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."26" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."26" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."26" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."26" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "26" ****************
        //************** "27" ****************
        MaChaine := RecLignePointage3."27";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."27" = 'P') OR (RecLignePointage3."27" = 'AU') OR (RecLignePointage3."27" = 'P-R') OR (RecLignePointage3."27" = 'MISS') OR (RecLignePointage3."27" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."27" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."27" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."27" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."27" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."27" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "27" ****************
        //************** "28" ****************
        MaChaine := RecLignePointage3."28";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."28" = 'P') OR (RecLignePointage3."28" = 'AU') OR (RecLignePointage3."28" = 'P-R') OR (RecLignePointage3."28" = 'MISS') OR (RecLignePointage3."28" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."28" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."28" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."28" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."28" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."28" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "28" ****************
        //************** "29" ****************
        MaChaine := RecLignePointage3."29";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."29" = 'P') OR (RecLignePointage3."29" = 'AU') OR (RecLignePointage3."29" = 'P-R') OR (RecLignePointage3."29" = 'MISS') OR (RecLignePointage3."29" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."29" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."29" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."29" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."29" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."29" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "29" ****************
        //************** "30" ****************
        MaChaine := RecLignePointage3."30";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."30" = 'P') OR (RecLignePointage3."30" = 'AU') OR (RecLignePointage3."30" = 'P-R') OR (RecLignePointage3."30" = 'MISS') OR (RecLignePointage3."30" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."30" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."30" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."30" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."30" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."30" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "30" ****************
        //************** "31" ****************
        MaChaine := RecLignePointage3."31";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (RecLignePointage3."31" = 'P') OR (RecLignePointage3."31" = 'AU') OR (RecLignePointage3."31" = 'P-R') OR (RecLignePointage3."31" = 'MISS') OR (RecLignePointage3."31" = 'FOR') THEN JoursPres += 1;
            IF (RecLignePointage3."31" = 'C') THEN "JoursCongé" += 1;
            IF (RecLignePointage3."31" = 'F') THEN "JoursFérié" += 1;
            IF (RecLignePointage3."31" = 'A') THEN JoursABS += 1;
            IF (RecLignePointage3."31" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (RecLignePointage3."31" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "31" ****************
        IF (RecLignePointage3."1" <> '.') AND (RecLignePointage3."1" <> '') AND (RecLignePointage3."1" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."2" <> '.') AND (RecLignePointage3."2" <> '') AND (RecLignePointage3."2" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."3" <> '.') AND (RecLignePointage3."3" <> '') AND (RecLignePointage3."3" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."4" <> '.') AND (RecLignePointage3."4" <> '') AND (RecLignePointage3."4" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."5" <> '.') AND (RecLignePointage3."5" <> '') AND (RecLignePointage3."5" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."6" <> '.') AND (RecLignePointage3."6" <> '') AND (RecLignePointage3."6" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."7" <> '.') AND (RecLignePointage3."7" <> '') AND (RecLignePointage3."7" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."8" <> '.') AND (RecLignePointage3."8" <> '') AND (RecLignePointage3."8" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."9" <> '.') AND (RecLignePointage3."9" <> '') AND (RecLignePointage3."9" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."10" <> '.') AND (RecLignePointage3."10" <> '') AND (RecLignePointage3."10" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."11" <> '.') AND (RecLignePointage3."11" <> '') AND (RecLignePointage3."11" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."12" <> '.') AND (RecLignePointage3."12" <> '') AND (RecLignePointage3."12" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."13" <> '.') AND (RecLignePointage3."13" <> '') AND (RecLignePointage3."13" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."14" <> '.') AND (RecLignePointage3."14" <> '') AND (RecLignePointage3."14" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."15" <> '.') AND (RecLignePointage3."15" <> '') AND (RecLignePointage3."15" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."16" <> '.') AND (RecLignePointage3."16" <> '') AND (RecLignePointage3."16" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."17" <> '.') AND (RecLignePointage3."17" <> '') AND (RecLignePointage3."17" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."18" <> '.') AND (RecLignePointage3."18" <> '') AND (RecLignePointage3."18" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."19" <> '.') AND (RecLignePointage3."19" <> '') AND (RecLignePointage3."19" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."20" <> '.') AND (RecLignePointage3."20" <> '') AND (RecLignePointage3."20" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."21" <> '.') AND (RecLignePointage3."21" <> '') AND (RecLignePointage3."21" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."22" <> '.') AND (RecLignePointage3."22" <> '') AND (RecLignePointage3."22" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."23" <> '.') AND (RecLignePointage3."23" <> '') AND (RecLignePointage3."23" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."24" <> '.') AND (RecLignePointage3."24" <> '') AND (RecLignePointage3."24" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."25" <> '.') AND (RecLignePointage3."25" <> '') AND (RecLignePointage3."25" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."26" <> '.') AND (RecLignePointage3."26" <> '') AND (RecLignePointage3."26" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."27" <> '.') AND (RecLignePointage3."27" <> '') AND (RecLignePointage3."27" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."28" <> '.') AND (RecLignePointage3."28" <> '') AND (RecLignePointage3."28" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."29" <> '.') AND (RecLignePointage3."29" <> '') AND (RecLignePointage3."29" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."30" <> '.') AND (RecLignePointage3."30" <> '') AND (RecLignePointage3."30" <> 'X') THEN JoursPointage += 1;
        IF (RecLignePointage3."31" <> '.') AND (RecLignePointage3."31" <> '') AND (RecLignePointage3."31" <> 'X') THEN JoursPointage += 1;
        RecLignePointage3."Nbre Jours Congé EXP" := "JoursCongéEXP";
        RecLignePointage3."Nbre Jours Absent" := JoursABS;
        RecLignePointage3."Nbre Jours Congé" := JoursCongé;
        RecLignePointage3."Nbre Jours Ferier" := JoursFérié;
        RecLignePointage3."Nbre Jours Present" := JoursPres;
        RecLignePointage3."Nbre Total Heures Presnt" := TotalHeurePre;
        IF JoursABS > 0 then
            RecLignePointage3."Taux d'absenteisme" := (JoursABS / JoursPointage) * 100
        ELSE
            RecLignePointage3."Taux d'absenteisme" := 0;
        RecLignePointage3.Modify();
    END;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text001: Label 'Il faut date de la journée !!';
        Text002: Label 'Pointage Validé avec succée';
        Text003: Label 'Voulez vous valider le pointage ?';
       // "RePointageEmployé": Record "Pointage Employé";
        "RecSalarié": Record Employee;
        "RecLignePointage": Record "Ligne Pointage Salarier Man";
        "RecLignePointage 2": Record "Ligne Pointage Salarier Man";
        GRecSalary: Record Employee;
        EDITABLESeuil: Boolean;
        RecUserSetup: Record "User Setup";
        RecLignePointage3: Record "Ligne Pointage Salarier Man";
        // GRegroupementErreurPointageSal: Record "Regroupent Erreur Pointage Sal";
        "RecLignePointage 3": Record "Ligne Pointage Salarier Man";
        RecConditionPointage: record "Condition de Pointage";
}
