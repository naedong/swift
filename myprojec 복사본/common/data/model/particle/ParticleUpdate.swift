//
//  ParticleUpdate.swift
//  myprojec
//
//  Created by E4 on 2023/01/11.
//


struct ParticleUpdate {
    typealias Generator = (inout Particles) -> Void

    var time = 0.0
    var beginEmitting = 0.0
    var endEmitting = Double.infinity
    var birthRate = 0.0
    var lastBirth = 0.0
    var generator: Generator = { _ in }
    var particles = [Particles]()

    var isActive: Bool { !particles.isEmpty }

    mutating func updateOldParticles(delta: Double) {
        let oldN = particles.count
        var newN = oldN
        var index = 0
        while index < newN {
            if particles[index].update(delta: delta) {
                index += 1
            } else {
                newN -= 1
                particles.swapAt(index, newN)
            }
        }
        if newN < oldN {
            particles.removeSubrange(newN ..< oldN)
        }
    }

    mutating func createNewParticles(delta: Double, newParticle: () -> Particles) {
        time += delta

        guard time >= beginEmitting && lastBirth < endEmitting else {
            lastBirth = time
            return
        }

        let birthInterval = 1 / birthRate
        while time - lastBirth >= birthInterval {
            lastBirth += birthInterval
            guard lastBirth >= beginEmitting && lastBirth < endEmitting else {
                continue
            }
            var particle = newParticle()
            generator(&particle)
            if particle.update(delta: time - lastBirth) {
                particles.append(particle)
            }
        }
    }

    func forEachParticle(do body: (Particles) -> Void) {
        for index in particles.indices {
            if let cell = particles[index].cell {
                cell.forEachParticle(do: body)
            } else {
                body(particles[index])
            }
        }
    }
}
