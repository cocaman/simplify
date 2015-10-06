package org.cf.smalivm.opcode;

import gnu.trove.map.TIntObjectMap;

import org.cf.smalivm.VirtualMachine;
import org.cf.smalivm.opcode.ConstOp.ConstantType;
import org.cf.util.Utils;
import org.jf.dexlib2.builder.BuilderInstruction;
import org.jf.dexlib2.builder.MethodLocation;
import org.jf.dexlib2.iface.instruction.NarrowLiteralInstruction;
import org.jf.dexlib2.iface.instruction.OneRegisterInstruction;
import org.jf.dexlib2.iface.instruction.ReferenceInstruction;
import org.jf.dexlib2.iface.instruction.WideLiteralInstruction;
import org.jf.dexlib2.iface.reference.Reference;
import org.jf.dexlib2.iface.reference.StringReference;
import org.jf.dexlib2.util.ReferenceUtil;

public class ConstOpFactory implements OpFactory {

    @Override
    public Op create(MethodLocation location, TIntObjectMap<MethodLocation> addressToLocation, VirtualMachine vm) {
        MethodLocation child = Utils.getNextLocation(location, addressToLocation);
        BuilderInstruction instruction = (BuilderInstruction) location.getInstruction();
        int destRegister = ((OneRegisterInstruction) instruction).getRegisterA();
        ConstantType constantType = null;
        Object literal = null;
        String opName = instruction.getOpcode().name;
        if (opName.matches("const-string(?:/jumbo)?")) {
            ReferenceInstruction instr = (ReferenceInstruction) location.getInstruction();
            literal = ((StringReference) instr.getReference()).getString();
            constantType = ConstantType.STRING;
        } else if (opName.endsWith("-class")) {
            ReferenceInstruction instr = (ReferenceInstruction) location.getInstruction();
            Reference classRef = instr.getReference();
            String className = ReferenceUtil.getReferenceString(classRef);
            literal = className;

            // Defer class lookup for execute. We may want to handle any possible errors there.
            if (vm.isLocalClass(className)) {
                constantType = ConstantType.LOCAL_CLASS;
            } else {
                constantType = ConstantType.CLASS;
            }
        } else if (opName.contains("-wide")) {
            WideLiteralInstruction instr = (WideLiteralInstruction) location.getInstruction();
            literal = instr.getWideLiteral();
            constantType = ConstantType.WIDE;
        } else {
            NarrowLiteralInstruction instr = (NarrowLiteralInstruction) location.getInstruction();
            literal = instr.getNarrowLiteral();
            constantType = ConstantType.NARROW;
        }

        return new ConstOp(location, child, destRegister, constantType, literal);
    }

}
