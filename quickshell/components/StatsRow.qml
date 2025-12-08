import QtQuick
import QtQuick.Layouts
import "./stats"

RowLayout {
    id: statsRow
    spacing: 0

    Kernel {}
    Separator {}

    Network {}
    Separator {}

    Battery {}
    Separator {}

    CpuUsage {}
    Separator {}

    MemoryUsage {}
    Separator {}

    DiskUsage {}
    Separator {}

    Volume {}
    Separator {}

    CpuTemp {}
}
