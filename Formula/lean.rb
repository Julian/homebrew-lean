class Lean < Formula
  desc "Theorem Prover"
  homepage "https://leanprover.github.io/"
  url "https://github.com/leanprover/lean4/archive/refs/tags/v4.10.0-rc1.tar.gz"
  sha256 "872a0278d2239aed4ac1ad53b28bf087135718f2a422d6349bc08e17891c56d1"
  license "Apache-2.0"
  head "https://github.com/leanprover/lean4.git"

  depends_on "cmake" => :build
  depends_on "coreutils"
  depends_on "gmp"
  depends_on "jemalloc"
  depends_on macos: :mojave

  conflicts_with "elan-init", because: "`lean` and `elan-init` install the same binaries"

  def install
    mkdir "build/release" do
      system "cmake", "../..", *std_cmake_args
      system "make", "-j#{ENV.make_jobs}", "install"
    end
  end

  test do
    (testpath/"hello.lean").write <<~EOS
      def id' {α : Type} (x : α) : α := x

      example (a b : Prop) : a ∧ b -> b ∧ a :=
      by
        intro h
        cases h
        exact ⟨by assumption, by assumption⟩
    EOS
    system bin/"lean", testpath/"hello.lean"
    system bin/"lake", "--help"
  end
end
