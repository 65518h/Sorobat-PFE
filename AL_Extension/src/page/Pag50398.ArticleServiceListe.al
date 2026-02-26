page 50398 "Article Service Liste"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = item;
    CardPageID = "Item Card";
    SourceTableView = where(Type = const(Service));
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Général';

                field("Search Description2"; wSearchFilter)
                {

                    ApplicationArea = all;
                    Caption = 'Désignation de recherche';
                    trigger OnValidate()
                    begin
                        //#5329
                        //RECHERCHE_ARTICLE
                        wSetFilters;
                        //RECHERCHE_ARTICLE//
                        //#5329//
                    end;

                }
                field("Search Option"; gSearchOption)
                {
                    ApplicationArea = all;
                    Caption = 'Option de recherche';
                    trigger OnValidate()
                    begin
                        //#8324
                        wSetFilters;
                        //#8324//
                    end;
                }
                field("Groupe compta. stock"; wInvPostingFilter)
                {
                    ApplicationArea = all;
                    Caption = 'Groupe compta. stock';
                    TableRelation = "Inventory Posting Group";
                    trigger OnValidate()
                    begin
                        //ITEM_CHARACT
                        wGetCharasteristicFilters;
                        //ITEM_CHARACT//
                        //RECHERCHE_ARTICLE
                        wSetFilters;
                        //RECHERCHE_ARTICLE//
                    end;

                }
                field("Location Filter"; Rec."Location Filter")
                {
                    ApplicationArea = all;
                    Caption = 'Filtre magasin';
                }
                field("Gen. Prod. Posting Group2"; wGenProdPostingFilter)
                {
                    ApplicationArea = all;
                    Caption = 'Code nature';
                    TableRelation = "Gen. Product Posting Group";
                    trigger OnValidate()
                    begin
                        //#8132
                        wSetFilters;
                        //#8132//
                    end;

                }


                field("Manufacturer Code"; wManufacturerFilter)
                {
                    ApplicationArea = all;
                    Caption = 'Code fabricant';

                    trigger OnValidate()
                    begin
                        //RECHERCHE_ARTICLE
                        wSetFilters;
                        //RECHERCHE_ARTICLE//
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    VAR
                        lManufacturer: Record Manufacturer;
                    BEGIN

                        //RECHERCHE_ARTICLE
                        lManufacturer.FIND('-');
                        IF PAGE.RUNMODAL(PAGE::Manufacturers, lManufacturer) = ACTION::LookupOK THEN BEGIN
                            IF wManufacturerFilter = '' THEN
                                wManufacturerFilter := lManufacturer.Code
                            ELSE
                                wManufacturerFilter := wManufacturerFilter + STRSUBSTNO('|%1', lManufacturer.Code);
                        END;
                        wSetFilters;
                        //RECHERCHE_ARTICLE//

                    end;
                }

                field("Item No."; wSearchNo)
                {
                    ApplicationArea = all;
                    Caption = 'N° article.';
                    trigger OnValidate()
                    begin
                        //RECHERCHE_ARTICLE
                        wSetFilters;
                        //RECHERCHE_ARTICLE//
                    end;
                }
                field("Nom Famille"; wFamille)
                {
                    Caption = 'Famille';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        //RECHERCHE_ARTICLE
                        wSetFilters;
                        //RECHERCHE_ARTICLE//
                    end;

                }

            }

            repeater(Articles)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;

                }
                field("Code Etude"; rec."Code Etude")
                {
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Description"; rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;


                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Last Direct Cost"; Rec."Last Direct Cost")
                {
                    ApplicationArea = All;
                }
                // field("Emplacement Bati Depot z4"; Rec."Emplacement Bati Depot z4")
                // {
                //     ApplicationArea = All;
                // }
                field("Tree Code"; Rec."Tree Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
    PROCEDURE wGetCharasteristicFilters();
    BEGIN

        //ITEM_CHARACT
        IF wInvPostingFilter = '' THEN
            wInvPostingGroup.INIT
        ELSE
            IF NOT wInvPostingGroup.GET(wInvPostingFilter) THEN
                wInvPostingGroup.INIT;

        rec.SETRANGE("Characteristic 1");
        rec.SETRANGE("Characteristic 2");
        rec.SETRANGE("Characteristic 3");
        rec.SETRANGE("Characteristic 4");
        rec.SETRANGE("Characteristic 5");
        rec.SETRANGE("Characteristic 6");
        rec.SETRANGE("Characteristic 7");
        rec.SETRANGE("Characteristic 8");
        rec.SETRANGE("Characteristic 9");

        wItemCharact[1] := '';
        wItemCharact[2] := '';
        wItemCharact[3] := '';
        wItemCharact[4] := '';
        wItemCharact[5] := '';
        wItemCharact[6] := '';
        wItemCharact[7] := '';
        wItemCharact[8] := '';
        wItemCharact[9] := '';




        "wFilterCaract1VISIBLE" := (wInvPostingGroup."Characteristic 1" <> '');
        wFilterCaract2VISIBLE := (wInvPostingGroup."Characteristic 2" <> '');
        wFilterCaract3VISIBLE := (wInvPostingGroup."Characteristic 3" <> '');
        wFilterCaract4VISIBLE := (wInvPostingGroup."Characteristic 4" <> '');
        wFilterCaract5VISIBLE := (wInvPostingGroup."Characteristic 5" <> '');
        wFilterCaract6VISIBLE := (wInvPostingGroup."Characteristic 6" <> '');
        wFilterCaract7VISIBLE := (wInvPostingGroup."Characteristic 7" <> '');
        wFilterCaract8VISIBLE := (wInvPostingGroup."Characteristic 8" <> '');
        wFilterCaract9VISIBLE := (wInvPostingGroup."Characteristic 9" <> '');

        wItemCaract1VISIBLE := (wInvPostingGroup."Characteristic 1" <> '');
        wItemCaract2VISIBLE := (wInvPostingGroup."Characteristic 2" <> '');
        wItemCaract3VISIBLE := (wInvPostingGroup."Characteristic 3" <> '');
        wItemCaract4VISIBLE := (wInvPostingGroup."Characteristic 4" <> '');
        wItemCaract5VISIBLE := (wInvPostingGroup."Characteristic 5" <> '');
        wItemCaract6VISIBLE := (wInvPostingGroup."Characteristic 6" <> '');
        wItemCaract7VISIBLE := (wInvPostingGroup."Characteristic 7" <> '');
        wItemCaract8VISIBLE := (wInvPostingGroup."Characteristic 8" <> '');
        wItemCaract9VISIBLE := (wInvPostingGroup."Characteristic 9" <> '');
        //ITEM_CHARACT//
    END;

    PROCEDURE wSetFilters();
    BEGIN

        //RECHERCHE_ARTICLE
        rec.SETRANGE("Tree Code");
        IF wSearchFilter <> '' THEN
            rec.SETCURRENTKEY("Search Description")
        ELSE
            IF wInvPostingFilter <> '' THEN
                rec.SETCURRENTKEY("Inventory Posting Group")
            ELSE
                IF wGenProdPostingFilter <> '' THEN
                    rec.SETCURRENTKEY("Gen. Prod. Posting Group")
                //#612
                ELSE
                    IF wSearchNo <> '' THEN
                        rec.SETCURRENTKEY("No.")

                    else
                        if wFamille <> '' then
                            rec.SETCURRENTKEY("Nom Famille");
        //#612

        IF wSearchFilter = '' THEN
            rec.SETRANGE("Search Description")
        ELSE
          //#8324
          //  SETFILTER("Search Description",wSearchFilter+'*');
          BEGIN
            CASE gSearchOption OF
                gSearchOption::"Begin":
                    rec.SETFILTER("Search Description", '@' + wSearchFilter + '*');
                gSearchOption::"End":
                    rec.SETFILTER("Search Description", '@*' + wSearchFilter);
                gSearchOption::Part:
                    rec.SETFILTER("Search Description", '@*' + wSearchFilter + '*');
            END;
        END;
        //#8324//

        IF wInvPostingFilter = '' THEN
            rec.SETRANGE("Inventory Posting Group")
        ELSE
            rec.SETFILTER("Inventory Posting Group", wInvPostingFilter);

        IF wFamille = '' THEN
            rec.SETRANGE("Nom Famille")
        ELSE
            rec.SETFILTER("Nom Famille", wFamille);


        IF wGenProdPostingFilter = '' THEN
            rec.SETRANGE("Gen. Prod. Posting Group")
        ELSE
            rec.SETFILTER("Gen. Prod. Posting Group", wGenProdPostingFilter);

        IF wManufacturerFilter = '' THEN
            rec.SETRANGE("Manufacturer Code")
        ELSE
            rec.SETFILTER("Manufacturer Code", wManufacturerFilter);

        //#612
        IF wSearchNo = '' THEN
            rec.SETRANGE("No.")



        ELSE BEGIN   // Ajouter Par HJ DSFT
            CASE gSearchOption OF
                gSearchOption::"Begin":
                    rec.SETFILTER("No.", '@' + wSearchNo + '*');
                gSearchOption::"End":
                    rec.SETFILTER("No.", '@*' + wSearchNo);
                gSearchOption::Part:
                    rec.SETFILTER("No.", '@*' + wSearchNo + '*');
            END;
        END; // Ajouter Par HJ DSFT
             // Arrete Par HJ DSFT
             //  IF (STRPOS(wSearchNo,'*') > 0) THEN
             //    SETFILTER("No.",wSearchNo)
             //  ELSE
             //    IF NOT GET(wSearchNo) THEN
             //      MESSAGE(tNoNotFound);
             // Arrete Par HJ DSFT
             //#612//

        Currpage.UPDATE(FALSE);
    END;

    var
        wInvPostingGroup: Record "Inventory Posting Group";
        wNavibat: Record NavibatSetup;
        wInvPostingFilter: Code[20];
        wCurrInvPosting: Code[20];
        wItemCharact: ARRAY[10] OF Code[20];
        wPrevCode: Code[20];
        wExtended: Boolean;
        wKOPyramid: Boolean;
        wAfterActivate: Boolean;
        wSearchFilter: Text[250];
        wGenProdPostingFilter: Text[250];
        wManufacturerFilter: Text[255];
        wSearchNo: Text[20];
        wFamille: Text[50];
        gSearchOption: Option "Begin","End","Part";
        "// DSFT": Integer;
        RecItem: Record Item;
        tNoNotFound: Label 'Item not found;FRA=Article non trouvé';
        Text001: Label 'The last number of this family is %1';

        "wFilterCaract1VISIBLE": Boolean;
        "wFilterCaract2VISIBLE": Boolean;
        "wFilterCaract3VISIBLE": Boolean;
        "wFilterCaract4VISIBLE": Boolean;
        "wFilterCaract5VISIBLE": Boolean;
        "wFilterCaract6VISIBLE": Boolean;
        "wFilterCaract7VISIBLE": Boolean;
        "wFilterCaract8VISIBLE": Boolean;
        "wFilterCaract9VISIBLE": Boolean;

        "wItemCaract1VISIBLE": Boolean;
        "wItemCaract2VISIBLE": Boolean;
        "wItemCaract3VISIBLE": Boolean;
        "wItemCaract4VISIBLE": Boolean;
        "wItemCaract5VISIBLE": Boolean;
        "wItemCaract6VISIBLE": Boolean;
        "wItemCaract7VISIBLE": Boolean;
        "wItemCaract8VISIBLE": Boolean;
        "wItemCaract9VISIBLE": Boolean;
        "B1VISIBLE": Boolean;
        "B2VISIBLE": Boolean;
        "PyramidSubformVISIBLE": Boolean;
        PyramidSubformENABLED: Boolean;
        "B1ENABLED": Boolean;
        "B2ENABLED": Boolean;
        "ExtendedSubformVISIBLE": Boolean;

}