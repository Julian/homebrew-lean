class Lean < Formula
  desc "Theorem Prover"
  homepage "https://leanprover.github.io/"
  url "https://github.com/leanprover/lean4/archive/refs/tags/v4.27.0.tar.gz"
  sha256 "6e81a8b5ffdd73bb0911ad7bdb0b14616137c4b54610036b8c1b50856fe0b550"
  license "Apache-2.0"
  head "https://github.com/leanprover/lean4.git"

  # Otherwise you seem to always need to set LEAN_CC
  env :std

  depends_on "cmake" => :build
  depends_on "gmp"
  depends_on "libuv"
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
