codeunit 50040 ResourceFindCostEvent
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Resource-Find Cost", 'OnBeforeFindResUnitCost', '', true, true)]
    local procedure OnBeforeFindResUnitCost(var ResourceCost: Record "Resource Cost"; var IsHandled: Boolean)
    begin
        // fFindResUnitCost(ResourceCost);
        // IsHandled := true;
    end;

    PROCEDURE OLDwFindResUnitCost(VAR NearestResCost0: Record "Resource Cost");
    VAR
        lResCost: Record "Resource Cost";
        lNaviBatSetup: Record NavibatSetup;
        lFound: Boolean;
    BEGIN
        //see new function fFindResCost
        /*
              //lFound := FALSE;
              //lResCost.COPY(NearestResCost);

              //#4099

              WITH lResCost DO BEGIN
                lFound := lFindCostPerCode(lResCost);
                IF NOT lFound THEN BEGIN
                  Res.GET(NearestResCost.Code);
                  lFound := lFindCostPerGrp(lResCost);
              //  END ELSE
              //    lFound := lFindCostPerAll(lResCost);
                  IF NOT lFound THEN
                    lFound := lFindCostPerAll(lResCost);
                END;

              WITH lResCost DO BEGIN
                Res.GET(NearestResCost.Code);
                IF Res.Status = Res.Status::External THEN BEGIN
                    lFound := lFindCostPerCode(lResCost);
                    IF NOT lFound THEN BEGIN
                      lFound := lFindCostPerGrp(lResCost);
                      IF NOT lFound THEN
                        lFound := lFindCostPerAll(lResCost);
                    END;
                END;
              //Recherche sans mission ni code mission
                IF NOT lFound THEN BEGIN
              //par Nø de ressource
                  RESET;
                  SETRANGE(Type,Type::Resource);
                  SETRANGE(Code,NearestResCost.Code);
                  SETRANGE("Work Type Code",NearestResCost."Work Type Code");
                  SETRANGE("Starting Date",0D,NearestResCost."Starting Date");
                  lFound := NOT ISEMPTY;
                  IF NOT lFound THEN BEGIN
              //par groupe de ressource
                    SETRANGE(Type,Type::"Group(Resource)");
              //#7382

                    //5513
                    //SETRANGE(Code,NearestResCost."Resource Group No.");
              //      SETRANGE(Code,Res."Resource Group No.");
                    //5513//

                    SETRANGE(Code,NearestResCost."Resource Group No.");
              //#7382//
                    lFound := NOT ISEMPTY;
                    IF NOT lFound THEN BEGIN
              //pour tous
                      SETRANGE(Type,Type::All);
                      SETRANGE(Code,'');
                      lFound := NOT ISEMPTY;
                    END;
                  END;
                END;
              //#4099//


                IF lFound THEN BEGIN
                  FIND('+');
                  NearestResCost := lResCost;
                END ELSE BEGIN
                  lNaviBatSetup.GET2;
                  IF (Res."Unit Cost" = 0) AND lNaviBatSetup."Check Resource Cost" THEN BEGIN
                    MESSAGE(Text1100280000,
                         NearestResCost.Code,
                         NearestResCost.FIELDCAPTION("Work Type Code"),NearestResCost."Work Type Code",
                         NearestResCost."Starting Date");
                    NearestResCost.INIT;
                    NearestResCost.Code  := Res."No.";
                    NearestResCost."Direct Unit Cost" := Res."Direct Unit Cost";
                    NearestResCost."Unit Cost" := Res."Unit Cost";
                  END ELSE BEGIN
                    NearestResCost.INIT;
                    NearestResCost.Code  := Res."No.";
                    NearestResCost."Direct Unit Cost" := Res."Direct Unit Cost";
                    NearestResCost."Unit Cost" := Res."Unit Cost";
                  END;
                END;
              END;
              */
    END;

    LOCAL PROCEDURE lFindCostPerCode(VAR NearestResCost: Record "Resource Cost"): Boolean;
    BEGIN
        WITH NearestResCost DO BEGIN
            RESET;
            SETRANGE(Type, Type::Resource);
            SETRANGE(Code, NearestResCost.Code);
            SETRANGE("Work Type Code", NearestResCost."Work Type Code");
            SETRANGE("Starting Date", 0D, NearestResCost."Starting Date");
            SETRANGE("Vendor No.", NearestResCost."Vendor No.");
            wFindCode := NOT ISEMPTY;
            IF NOT wFindCode THEN
                EXIT(FALSE);
            //recherche avec la ressource et la mission avec le code mission renseign‚ ou vide
            SETFILTER("Mission Code", '%1|%2', NearestResCost."Mission Code", '');
            SETRANGE("Mission No.", NearestResCost."Mission No.");
            IF NOT ISEMPTY THEN
                EXIT(TRUE);

            //recherche avec la ressource et le code mission sans num‚ro de mission
            SETRANGE("Mission Code", NearestResCost."Mission Code");
            SETRANGE("Mission No.", '');
            IF NOT ISEMPTY THEN
                EXIT(TRUE);
        END;
        EXIT(FALSE);
    END;

    LOCAL PROCEDURE lFindCostPerGrp(VAR NearestResCost: Record "Resource Cost"): Boolean;
    BEGIN
        WITH NearestResCost DO BEGIN
            RESET;
            SETRANGE(Type, Type::"Group(Resource)");
            SETRANGE(Code, NearestResCost."Resource Group No.");
            SETRANGE("Work Type Code", NearestResCost."Work Type Code");
            SETRANGE("Starting Date", 0D, NearestResCost."Starting Date");
            SETRANGE("Vendor No.", NearestResCost."Vendor No.");
            wFindGrp := NOT ISEMPTY;
            IF NOT wFindGrp THEN
                EXIT(FALSE);
            //recherche avec le groupe et la mission
            //  Res.GET(NearestResCost.Code);
            SETFILTER("Mission Code", '%1|%2', NearestResCost."Mission Code", '');
            SETRANGE("Mission No.", NearestResCost."Mission No.");
            IF NOT ISEMPTY THEN
                EXIT(TRUE);

            //recherche avec le groupe et le code mission
            SETRANGE("Mission Code", NearestResCost."Mission Code");
            SETRANGE("Mission No.", '');
            IF NOT ISEMPTY THEN
                EXIT(TRUE);
        END;
        EXIT(FALSE);
    END;

    LOCAL PROCEDURE lFindCostPerAll(VAR NearestResCost: Record "Resource Cost"): Boolean;
    BEGIN
        WITH NearestResCost DO BEGIN
            RESET;
            SETRANGE(Type, Type::All);
            SETRANGE(Code, '');
            SETRANGE("Work Type Code", NearestResCost."Work Type Code");
            SETRANGE("Starting Date", 0D, NearestResCost."Starting Date");
            SETRANGE("Vendor No.", NearestResCost."Vendor No.");
            wFindAll := NOT ISEMPTY;
            IF NOT wFindAll THEN
                EXIT(FALSE);
            //recherche avec la ressource et la mission avec le code mission renseign‚ ou vide
            SETFILTER("Mission Code", '%1|%2', NearestResCost."Mission Code", '');
            SETRANGE("Mission No.", NearestResCost."Mission No.");
            IF NOT ISEMPTY THEN
                EXIT(TRUE);

            //recherche avec la ressource et le code mission sans num‚ro de mission
            SETRANGE("Mission Code", NearestResCost."Mission Code");
            SETRANGE("Mission No.", '');
            IF NOT ISEMPTY THEN
                EXIT(TRUE);
        END;
        EXIT(FALSE);
    END;

    PROCEDURE fFindResUnitCost(VAR pResCost: Record "Resource Cost");
    VAR
        lNaviBatSetup: Record NavibatSetup;
        ltResCostNotFound: Label 'Coût non trouvé pour la ressource %1, %2 %3 au %4.';
    BEGIN
        WITH pResCost DO BEGIN
            Res.GET(pResCost.Code);
            IF Res.Status = Res.Status::External THEN BEGIN
                RESET;
                SETRANGE(Type, Type::All);
                SETRANGE(Code, '');
                SETFILTER("Work Type Code", '%1|%2', pResCost."Work Type Code", '');
                SETRANGE("Starting Date", 0D, pResCost."Starting Date");
                SETRANGE("Vendor No.", pResCost."Vendor No.");
                SETRANGE("Mission No.", pResCost."Mission No.");
                SETFILTER("Mission Code", '%1|%2', pResCost."Mission Code", '');
                IF FINDLAST THEN
                    EXIT;
                //    SETFILTER("Mission Code",'%1','');
                //    SETRANGE("Mission No.");
                //    IF FINDLAST THEN
                //      EXIT;
                //#9123
                //Key : Type,Code,Work Type Code,Starting Date,Vendor No.,Mission Code,Mission No.
                //recherche /Ressource
                RESET;
                SETRANGE(Type, Type::Resource);
                SETRANGE(Code, pResCost.Code);
                SETFILTER("Work Type Code", '%1|%2', pResCost."Work Type Code", '');
                SETRANGE("Starting Date", 0D, pResCost."Starting Date");
                SETRANGE("Vendor No.", "Vendor No.");
                SETRANGE("Mission Code", "Mission Code");
                SETRANGE("Mission No.", pResCost."Mission No.");
                IF FINDLAST THEN
                    EXIT;
                SETRANGE("Mission Code");
                IF FINDLAST THEN
                    EXIT;
                SETRANGE(Code);
                IF FINDLAST THEN
                    EXIT;
                //recherche /Groupe de ressources (RG4...)
                SETRANGE(Type, Type::"Group(Resource)");
                SETRANGE(Code, pResCost."Resource Group No.");
                SETRANGE("Mission Code", "Mission Code");
                SETRANGE("Mission No.");
                IF FINDLAST THEN
                    EXIT;
                SETRANGE("Mission Code");
                IF FINDLAST THEN
                    EXIT;
                SETRANGE(Code);
                SETRANGE("Mission Code", "Mission Code");
                IF FINDLAST THEN
                    EXIT;
                //(RG7..)
                SETRANGE("Vendor No.");
                SETRANGE("Mission Code");
                SETRANGE("Mission No.");
                IF FINDLAST THEN
                    EXIT;
                //#9123//
            END;

            RESET;
            //recherche /Groupe de ressources
            SETRANGE(Type, Type::"Group(Resource)");
            SETRANGE(Code, pResCost."Resource Group No.");
            SETFILTER("Work Type Code", '%1|%2', pResCost."Work Type Code", '');
            SETRANGE("Starting Date", 0D, pResCost."Starting Date");
            IF FINDLAST THEN
                EXIT;
            SETRANGE(Type, Type::Resource);
            SETRANGE(Code, pResCost.Code);
            IF FINDLAST THEN
                EXIT;
            //recherche /ressource
            SETRANGE(Type, Type::All);
            SETRANGE(Code, '');
            IF FINDLAST THEN
                EXIT;

            lNaviBatSetup.GET2;
            IF lNaviBatSetup."Check Resource Cost" AND (Res."Unit Cost" = 0) THEN
                MESSAGE(ltResCostNotFound,
                  pResCost.Code, pResCost.FIELDCAPTION("Work Type Code"), pResCost."Work Type Code", pResCost."Starting Date");

            INIT;
            IF Res.Type = Res.Type::Structure THEN
                Code := ''
            ELSE
                Code := Res."No.";
            "Direct Unit Cost" := Res."Direct Unit Cost";
            "Unit Cost" := Res."Unit Cost";
        END;
    END;

    var
        myInt: Integer;
        Res: Record Resource;
        wFindCode, wFindGrp, wFindAll : Boolean;
}