Codeunit 52048885 "Machine centerEquipment update"
{
    //GL2024  ID dans Nav 2009 : "39002012"
    trigger OnRun()
    begin
    end;

    var
        machine: Record "Machine Center";
    //GL3900

    /*
        procedure MachineUpdate(Equipment: Record Equipement)
        begin
            machine.Get(Equipment."machine center");
            machine.Validate(Name, CopyStr(Equipment.Désignation, 1, 30));
            machine.Capacity := 1;
            machine.Modify(true);
        end;


        procedure EquipToMachine(OldEquipment: Record Equipement; Equipment: Record Equipement)
        begin
            if (Equipment."machine center" <> '') and
             ((OldEquipment."machine center" <> Equipment."machine center") or
              (OldEquipment.Désignation <> Equipment.Désignation))

          then
                MachineUpdate(Equipment)
            else
                exit;
        end;*///GL3900
}

